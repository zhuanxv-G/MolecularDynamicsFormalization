# BATCH14：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：53；上下文读取该节相邻页。
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

### MD-1.5.2-ActionAngleCoordinates

```json
{
  "source_id": "MD-1.5.2-ActionAngleCoordinates",
  "kind": "definition",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "Define new variables\n\\[x=\\sqrt{2I/\\Omega}\\cos\\theta,\\qquad v=\\sqrt{2I\\Omega}\\sin\\theta.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "Ω>0，I>0非退化action；(I,θ)是新坐标对，不另拆单符号。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.oscillatorActionAngle",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-127",
    "CH01-202"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def oscillatorActionAngle (Ω I θ : ℝ) : ℝ × ℝ :=
  (Real.sqrt (2*I/Ω)*Real.cos θ, Real.sqrt (2*I*Ω)*Real.sin θ)
```

### MD-1.5.2-ActionEnergy

```json
{
  "source_id": "MD-1.5.2-ActionEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "In these variables, the energy is $E=I\\Omega$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.actionenergy",
  "extra_assumptions": [
    "Ω>0，I≥0；harmonicActionVelocity_formula保证v的sqrt(2IΩ)形式一致。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-128"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem actionenergy :
  ∀ (Ω J θ : ℝ) (hΩ : 0 < Ω) (hJ : 0 ≤ J),
    harmonicScalarEnergy Ω (harmonicActionPosition Ω J θ)
      (harmonicActionVelocity Ω J θ) = J * Ω
```

### MD-1.5.2-ActionODE

```json
{
  "source_id": "MD-1.5.2-ActionODE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "Introducing these formulas into the equations of motion and simplifying leads to $\\dot I=0$, $\\dot\\theta=-\\Omega$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.actionode",
  "extra_assumptions": [
    "Ω,I正；真实I′、θ′，非退化局部角坐标。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-129"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem actionode :
  ∀ (Ω : ℝ) (J θ : ℝ → ℝ) (d omega t : ℝ)
    (hΩ : 0 < Ω) (hJ : 0 < J t) (hd : HasDerivAt J d t) (hθ : HasDerivAt θ omega t),
    (HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t) ↔ d = 0 ∧ omega = -Ω
```

### MD-1.5.2-ActionSolution

```json
{
  "source_id": "MD-1.5.2-ActionSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "The first equation expresses the constancy of energy; the second describes a rotation with frequency $\\Omega$, i.e., the solution is $\\theta(t)=\\theta(0)-\\Omega t$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "取s=0即原文公式；签名同时给I(t)=I(s)。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.actionsolution",
  "extra_assumptions": [
    "连通开放时间窗含起始s；正action及Ω，真实坐标解。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-130"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem actionsolution :
  ∀ (Ω a b : ℝ) (J θ : ℝ → ℝ)
    (hΩ : 0 < Ω) (hJ : ∀ t ∈ Ioo a b, 0 < J t)
    (hreg : ∀ t ∈ Ioo a b, DifferentiableAt ℝ J t ∧ DifferentiableAt ℝ θ t)
    (hODE : ∀ t ∈ Ioo a b,
      HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    J t = J s ∧ θ t = θ s - Ω * (t - s)
```

### MD-1.5.2-HarmonicTorus

```json
{
  "source_id": "MD-1.5.2-HarmonicTorus",
  "kind": "definition",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "The same change of variables $(x_j,v_j)\\to(I_j,\\theta_j)$, applied to each oscillator, would yield equations of motion $\\dot I_j=0$, $\\dot\\theta_j=-\\Omega_j$. This describes a point winding about a $d$-dimensional torus defined by angular rotation frequencies $\\Omega_j$ and radii $|I_j|$ (Fig. 1.14).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "HarmonicTorus d = Fin d→Real.Angle；角模2π；I为固定action，半径的几何映射不新造定理。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.oscillatorTorusMotion",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-131"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def oscillatorTorusMotion {d : ℕ} (I Ω : Fin d → ℝ) (θ₀ : HarmonicTorus d)
    (t : ℝ) : (Fin d → ℝ) × HarmonicTorus d := (I, harmonicTorusRotation Ω t θ₀)
```

### MD-1.5.2-TorusPeriod

```json
{
  "source_id": "MD-1.5.2-TorusPeriod",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "Depending on the ratio of frequencies such motions may be periodic or quasi-periodic;",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.torusperiod",
  "extra_assumptions": [
    "给定周期T；每频率×T为整数圈是精确共振条件；原句没有单独定义commensurate。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-132"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem torusperiod :
  ∀ {n : ℕ}
    (Ω : Fin n → ℝ) (T : ℝ) (θ : HarmonicTorus n),
    Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T ↔
      ∀ j, ∃ k : ℤ, (k : ℝ) * (2 * Real.pi) = Ω j * T
```

### MD-1.5.2-TorusDense

```json
{
  "source_id": "MD-1.5.2-TorusDense",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "in the latter case the paths do not “close up” but instead we see the curve gradually fills in the surface of the torus.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文用ratio of frequencies描述高维填满环面，未区分准周期子环面与全维整数无共振；须导师明确。"
    }
  ],
  "lean_decl": "MD.Ch01.torusdense",
  "extra_assumptions": [
    "高维全整数关系无共振；仅成对频率比无理不足，此为原文quasi-periodic intended meaning的数学资格。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-133"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem torusdense :
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ)
```

### MD-1.5.2-LocalActionAngleReduction

```json
{
  "source_id": "MD-1.5.2-LocalActionAngleReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "More generally, one finds occasional examples of nonlinear systems which possess as many independent first integrals as degrees of freedom (satisfying a certain “involution” condition); such systems may be reduced via a coordinate transformation to action-angle variables, i.e. they exhibit tori motion.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "local canonical action-angle与全局torus motion不同；本条只保留局部规约，原文最后tori motion需额外紧共同能量层假设。"
    }
  ],
  "lean_decl": "MD.Ch01.local_action_angle_reduction",
  "extra_assumptions": [
    "全部积分C∞且Poisson括号两两零；正则共同能量层紧、连通；满秩=独立。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-134"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem local_action_angle_reduction :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    IsCompact S → IsConnected S →
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩)
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
