# BATCH13：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：52, 53；上下文读取该节相邻页。
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

### MD-1.5.2-KeplerMomentum

```json
{
  "source_id": "MD-1.5.2-KeplerMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "Note that a consequence of fixing one of the bodies in the Kepler problem is that the two components of the total momentum vector, i.e. $(m\\dot x,m\\dot y)$, are obviously no longer conserved;",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.keplermomentum",
  "extra_assumptions": [
    "q≠0；单位质量。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-201"
  ]
}
```

```lean
theorem keplermomentum :
  ∀ q : Position 2, q ≠ 0 → keplerForce q ≠ 0
```

### MD-1.5.2-PolarCoordinates

```json
{
  "source_id": "MD-1.5.2-PolarCoordinates",
  "kind": "definition",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "In polar coordinates $(x,y)=(r\\cos\\theta,r\\sin\\theta)$, the Lagrangian $L$ for the Kepler problem is",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "r>0，角实数局部提升；0处排除。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.polarCoordinates",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-118"
  ]
}
```

```lean
def polarCoordinates (r θ : ℝ) : Position 2 := WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ]
```

### MD-1.5.2-KeplerPolarLagrangian

```json
{
  "source_id": "MD-1.5.2-KeplerPolarLagrangian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "\\[L=K-U=\\frac12(\\dot r\\cos\\theta-r\\dot\\theta\\sin\\theta)^2+\\frac12(\\dot r\\sin\\theta+r\\dot\\theta\\cos\\theta)^2+\\frac1r=\\frac{\\dot r^2}2+\\frac{r^2\\dot\\theta^2}2+\\frac1r.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "v=r′、ω=θ′；公式为代数恒等式，物理域r>0。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.keplerpolarlagrangian",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-119"
  ]
}
```

```lean
theorem keplerpolarlagrangian :
  ∀ (r θ v omega : ℝ),
    ((v * Real.cos θ - r * omega * Real.sin θ) ^ 2 +
      (v * Real.sin θ + r * omega * Real.cos θ) ^ 2) / 2 + 1 / r =
    v ^ 2 / 2 + r ^ 2 * omega ^ 2 / 2 + 1 / r
```

### MD-1.5.2-KeplerPolarODE

```json
{
  "source_id": "MD-1.5.2-KeplerPolarODE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "Working these out directly, one gets\n\\[\\ddot r=-\\frac1{r^2}+r\\dot\\theta^2,\\qquad0=\\frac{\\mathrm d}{\\mathrm dt}(r^2\\dot\\theta).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "IsKeplerPolarEulerLagrangeOn包含真实一阶/二阶导数及r≠0，展开定义核对。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.keplerpolarode",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-120"
  ]
}
```

```lean
theorem keplerpolarode :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ),
    IsKeplerPolarEulerLagrangeOn I r θ v omega ↔
      ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (omega t) t ∧
        HasDerivAt v (r t * omega t ^ 2 - (r t ^ 2)⁻¹) t ∧
        HasDerivAt (fun u => r u ^ 2 * omega u) 0 t
```

### MD-1.5.2-PolarAngularIdentity

```json
{
  "source_id": "MD-1.5.2-PolarAngularIdentity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "Expressed in polar coordinates this is\n\\[l_z=(r\\cos\\theta)(\\dot r\\sin\\theta+r\\dot\\theta\\cos\\theta)-(r\\sin\\theta)(\\dot r\\cos\\theta-r\\dot\\theta\\sin\\theta)\n=r^2\\dot\\theta(\\cos^2\\theta+\\sin^2\\theta)=r^2\\dot\\theta,\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "保留三角恒等式计算中的真实速度对应，代数定理不需r>0。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.polarangularidentity",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-121"
  ]
}
```

```lean
theorem polarangularidentity :
  ∀ (r θ v omega : ℝ),
    (r * Real.cos θ) * (v * Real.sin θ + r * omega * Real.cos θ) -
      (r * Real.sin θ) * (v * Real.cos θ - r * omega * Real.sin θ) = r ^ 2 * omega
```

### MD-1.5.2-KeplerRadialReduction

```json
{
  "source_id": "MD-1.5.2-KeplerRadialReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "Taking this quantity as fixed, we may write the remaining equation as $\\ddot r=-1/r^2+l_z^2/r^3$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.keplerradialreduction",
  "extra_assumptions": [
    "r非零、角动量l固定，既有极坐标Euler–Lagrange真实解；角动量常性先前已证。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-122"
  ]
}
```

```lean
theorem keplerradialreduction :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn I r θ v omega) (t : ℝ) (ht : t ∈ I)
    (l : ℝ) (hl : r t ^ 2 * omega t = l),
    HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t
```

### MD-1.5.2-KeplerRadialEnergy

```json
{
  "source_id": "MD-1.5.2-KeplerRadialEnergy",
  "kind": "definition",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "system with energy\n\\[\\widehat E(r,\\dot r)=\\frac{\\dot r^2}2-\\frac1r+\\frac{l_z^2}{2r^2}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "r>0；ℓ固定z角动量；原句跨p.29–30，system指径向单自由度系统。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.radialKeplerEnergy",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-123"
  ]
}
```

```lean
def radialKeplerEnergy (ℓ r v : ℝ) : ℝ := v^2/2-1/r+ℓ^2/(2*r^2)
```

### MD-1.5.2-KeplerFullSolution

```json
{
  "source_id": "MD-1.5.2-KeplerFullSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "From our previous work, we know that this system (a single degree of freedom system) can be solved for $r$ as a function of $t$ and the initial conditions. Once $r=r(t)$ is known, we may obtain $\\theta$ by integration:\n\\[\\theta=\\theta(0)+\\int_0^t\\frac{l_z}{r^2(s)}\\,\\mathrm ds.\\]\nThe example shows that the full solution of the Kepler problem can be worked out given the initial conditions, as long as we are happy to express the solution in terms of antiderivatives of simple functions (and their inverses).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.kepler_full_solution",
  "extra_assumptions": [
    "完整非碰撞存在区间含0；原文不保证径向碰撞时仍有全局解；角θ为区间上的连续实提升。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-124",
    "CH01-125",
    "CH01-126"
  ]
}
```

```lean
theorem kepler_full_solution (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z) :
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = polarCoordinates (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = ((polarCoordinates (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀])
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
