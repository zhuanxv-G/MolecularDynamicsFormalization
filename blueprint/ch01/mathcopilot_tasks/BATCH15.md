# BATCH15：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：54, 55；上下文读取该节相邻页。
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

### MD-1.5.3-Equilibrium

```json
{
  "source_id": "MD-1.5.3-Equilibrium",
  "kind": "definition",
  "label": null,
  "section": "1.5.3",
  "printed_page": "31",
  "pdf_page": "54",
  "statement_latex": "An equilibrium point of such system is a solution of $f(\\boldsymbol z)=0$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.equilibriumDefinition",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-135"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def equilibriumDefinition {n : ℕ} (f : Position n → Position n) (z : Position n) : Prop := f z = 0
```

### MD-1.5.3-ConstantEquilibrium

```json
{
  "source_id": "MD-1.5.3-ConstantEquilibrium",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "31",
  "pdf_page": "54",
  "statement_latex": "An equilibrium point $\\boldsymbol z^*$ corresponds to an equilibrium solution, since if we define a constant function $\\boldsymbol z(t)=\\boldsymbol z^*$ then we have $\\dot{\\boldsymbol z}(t)=f(\\boldsymbol z^*)=0$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.constantequilibrium",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-136"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem constantequilibrium :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (f : E → E) (z₀ : E) (t : ℝ),
    HasDerivAt (fun _ : ℝ => z₀) (f z₀) t ↔ f z₀ = 0
```

### MD-1.5.3-EquilibriumLinearization

```json
{
  "source_id": "MD-1.5.3-EquilibriumLinearization",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "31",
  "pdf_page": "54",
  "statement_latex": "We assume that $f$ is continuously differentiable in the vicinity of the equilibrium point $\\boldsymbol z^*$ and make use of the fact that $f(\\boldsymbol z)\\approx f(\\boldsymbol z^*)+f'(\\boldsymbol z^*)(\\boldsymbol z-\\boldsymbol z^*)$ for $\\|\\boldsymbol z-\\boldsymbol z^*\\|$ sufficiently small. Since $f(\\boldsymbol z^*)=0$ we have, defining $\\delta\\boldsymbol z:=\\boldsymbol z-\\boldsymbol z^*$,\n\\[\\frac{\\mathrm d\\delta\\boldsymbol z}{\\mathrm dt}=\\boldsymbol A\\delta\\boldsymbol z,\\qquad\\boldsymbol A=f'(\\boldsymbol z^*).\\]\nThe symbol $\\approx$ is not very precise.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "小o余项将≈精确定义为一阶近似；δ的线性ODE是近似系统，不声称非线性扰动精确满足Aδ。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.equilibriumlinearization",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-137",
    "CH01-138"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem equilibriumlinearization :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (z₀ h₀ : E) (t₀ : ℝ)
    (hF : ContDiffAt ℝ 1 f z₀) (heq : f z₀ = 0),
    ∃ δ : ℝ → E, δ t₀ = h₀ ∧
      (∀ t, HasDerivAt δ ((fderiv ℝ f z₀) (δ t)) t) ∧
      (equilibriumLinearizationRemainder f z₀ (fderiv ℝ f z₀)) =o[𝓝 0] (fun h : E => h)
```

### MD-1.5.3-Hyperbolic

```json
{
  "source_id": "MD-1.5.3-Hyperbolic",
  "kind": "definition",
  "label": null,
  "section": "1.5.3",
  "printed_page": "31–32",
  "pdf_page": "54–55",
  "statement_latex": "In case the equilibrium point is hyperbolic, meaning that the real parts of the eigenvalues of $\\boldsymbol A=f'(\\boldsymbol z^*)$ are nonzero,",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "实算子用复特征向量的实虚部编码；所有非零特征对对应实部a≠0。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hyperbolic",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-139"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def hyperbolic {n : ℕ} (A : Position n →L[ℝ] Position n) : Prop :=
  ∀ (a b : ℝ) (x y : Position n), (x ≠ 0 ∨ y ≠ 0) →
    A x = a • x - b • y → A y = b • x + a • y → a ≠ 0
```

### MD-1.5.3-HartmanGrobmanLiteral

```json
{
  "source_id": "MD-1.5.3-HartmanGrobmanLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "31–32",
  "pdf_page": "54–55",
  "statement_latex": "then one can infer that the solutions of the nonlinear and linear systems are in fact topologically conjugate: if $\\boldsymbol z$ is the solution of the nonlinear system and $\\delta\\boldsymbol z$ is the solution of the linear system, then there is a smooth, invertible map $\\boldsymbol\\Phi$ of $\\mathbb R^m$ defined in a neighborhood of the origin such that\n\\[\\boldsymbol z(t)=\\boldsymbol z^*+\\boldsymbol\\Phi(\\delta\\boldsymbol z(t)).\\]\nThis is referred to as the Hartman-Grobman theorem (for more discussion see [177], where this result is referred to as the “Linearization Theorem”; a proof may be found in [362]).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文smooth invertible强于常见Hartman–Grobman的homeomorphism，C1仅双曲不保证光滑共轭。"
    }
  ],
  "lean_decl": "MD.Ch01.hartmangrobmanliteral",
  "extra_assumptions": [
    "C1全域模型及真实全局流为局部应用的技术资格；共轭在轨迹保持局部域时断言。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-140"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem hartmangrobmanliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x)
```

### MD-1.5.3-LyapunovStability

```json
{
  "source_id": "MD-1.5.3-LyapunovStability",
  "kind": "definition",
  "label": null,
  "section": "1.5.3",
  "printed_page": "32",
  "pdf_page": "55",
  "statement_latex": "Let $\\boldsymbol z^*$ be an equilibrium point. We say that $\\boldsymbol z^*$ is stable (“in the sense of Lyapunov”) if, for all $\\epsilon$, there exists $\\delta$ such that, for all $\\boldsymbol z_0$ such that $\\|\\boldsymbol z_0-\\boldsymbol z^*\\|<\\delta$,\n\\[\\sup_{t\\geq0}\\|\\mathcal F_t(\\boldsymbol z_0)-\\boldsymbol z^*\\|<\\epsilon.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.lyapunovStable",
  "extra_assumptions": [
    "ε,δ正按Lyapunov容差惯例；有界性避免Lean实数总sup的未界伪结论。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-141"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def lyapunovStable {n : ℕ} (F : ℝ → Position n → Position n) (z : Position n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, ‖x-z‖ < δ →
    BddAbove (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) ∧
    sSup (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) < ε
```

### MD-1.5.3-HyperbolicStabilityTransfer

```json
{
  "source_id": "MD-1.5.3-HyperbolicStabilityTransfer",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "32",
  "pdf_page": "55",
  "statement_latex": "The Hartman-Grobman theorem clearly implies that the stability of a given hyperbolic equilibrium point $\\boldsymbol z^*$ of a nonlinear system can be inferred from the stability of the origin for the linearization of the system around $\\boldsymbol z^*$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hyperbolicstabilitytransfer",
  "extra_assumptions": [
    "C1及真实全局流；stable谓词的统一界<ε与原文严格sup形式等价。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-142"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem hyperbolicstabilitytransfer :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0)
```

### MD-1.5.3-HamiltonEquilibrium

```json
{
  "source_id": "MD-1.5.3-HamiltonEquilibrium",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "32",
  "pdf_page": "55",
  "statement_latex": "Observe that an equilibrium point $\\boldsymbol z^*=(\\boldsymbol q^*,\\boldsymbol p^*)$ of a Hamiltonian system in “kinetic plus potential” form\n\\[H(\\boldsymbol q,\\boldsymbol p)=\\boldsymbol p^T\\boldsymbol M^{-1}\\boldsymbol p/2+U(\\boldsymbol q)\\]\nwill always have $\\boldsymbol p^*=0$ and $\\nabla U(\\boldsymbol q^*)=0$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hamilton_equilibrium",
  "extra_assumptions": [
    "一般常M正定、U可微；heq为原文Hamilton平衡的两梯度定义。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-143"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem hamilton_equilibrium {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q)
    (heq : gradient (fun v => variableMassHamiltonian (fun _ => M) U q v) p = 0 ∧
      gradient (fun x => variableMassHamiltonian (fun _ => M) U x p) q = 0) :
    p = 0 ∧ gradient U q = 0
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
