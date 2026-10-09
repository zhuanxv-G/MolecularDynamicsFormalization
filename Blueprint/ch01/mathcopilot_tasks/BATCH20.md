# BATCH20：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：61, 62；上下文读取该节相邻页。
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

### MD-1.7-PlanarTrimerModel

```json
{
  "source_id": "MD-1.7-PlanarTrimerModel",
  "kind": "definition",
  "label": "Example 1.8 (Planar Lennard-Jones Trimer)",
  "section": "1.7",
  "printed_page": "38",
  "pdf_page": "61",
  "statement_latex": "One of the simplest illustrations of the chaotic nature of molecular systems is given by the Lennard-Jones model consisting of just three atoms with motion restricted to the plane. The energy is\n\\[E=K+U=\\frac{\\|\\dot{\\boldsymbol q}_1\\|^2}{2}+\\frac{\\|\\dot{\\boldsymbol q}_2\\|^2}{2}+\\frac{\\|\\dot{\\boldsymbol q}_3\\|^2}{2}+\\hat\\varphi_{\\mathrm{LJ}}(\\|\\boldsymbol q_1-\\boldsymbol q_2\\|)+\\hat\\varphi_{\\mathrm{LJ}}(\\|\\boldsymbol q_2-\\boldsymbol q_3\\|)+\\hat\\varphi_{\\mathrm{LJ}}(\\|\\boldsymbol q_1-\\boldsymbol q_3\\|),\\]\nwith the interatomic interaction given by $\\hat\\varphi_{\\mathrm{LJ}}(r)=4[r^{-12}-r^{-6}]$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "单位质量、平面R²、非碰撞物理域；inverse整数幂与(1/r)^k等价。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.planarTrimerEnergy",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": []
}
```

```lean
def planarTrimerEnergy (q v : Fin 3 → Position 2) : ℝ :=
  (∑ i, ‖v i‖^2/2) + lennardJonesPotential 1 1 ‖q 0-q 1‖ +
    lennardJonesPotential 1 1 ‖q 1-q 2‖ + lennardJonesPotential 1 1 ‖q 0-q 2‖
```

### MD-1.7-CentralPairPotential

```json
{
  "source_id": "MD-1.7-CentralPairPotential",
  "kind": "definition",
  "label": null,
  "section": "1.7",
  "printed_page": "38",
  "pdf_page": "61",
  "statement_latex": "In general, when the total potential is a sum of distance potentials\n\\[U=\\frac12\\sum_{i\\ne j}U_{ij},\\]\nwhere $U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j)=\\varphi_{ij}(\\|\\boldsymbol q_i-\\boldsymbol q_j\\|)$, we say that the system has central forces.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "φᵢⱼ=φⱼᵢ为同一无序对相互作用；qᵢ≠qⱼ和径向势可微用于后续导数，不是本定义存在条件。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.centralPairEnergy",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-174"
  ]
}
```

```lean
def centralPairEnergy {N : ℕ} (φ : Fin N → Fin N → ℝ → ℝ) (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.univ.erase i, φ i j (pairDistance (q i) (q j)))/2
```

### MD-1.7-CentralPairGradient

```json
{
  "source_id": "MD-1.7-CentralPairGradient",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "38",
  "pdf_page": "61",
  "statement_latex": "In this case,\n\\[\\frac\\partial{\\partial\\boldsymbol q_i}U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j)=-\\frac\\partial{\\partial\\boldsymbol q_j}U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j),\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.centralpairgradient",
  "extra_assumptions": [
    "势在非碰撞距离可微；partial为欧氏梯度。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-175"
  ]
}
```

```lean
theorem centralpairgradient :
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x => φ ‖x-r‖) q = -gradient (fun y => φ ‖q-y‖) r
```

### MD-1.7-CentralMomentum

```json
{
  "source_id": "MD-1.7-CentralMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "and so, for central forces,\n\\[\\sum_{i=1}^N m_i\\ddot{\\boldsymbol q}_i=0,\\]\nwhich expresses the constancy of the momentum.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "∑mᵢq̈ᵢ=0为PairCancellation及IsMechanicalSolutionOn的组合；bridge结论对每坐标守恒即整个向量守恒。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.centralmomentum",
  "extra_assumptions": [
    "逐对作用反对称推出净力零；真实Newton解和连通时间区间。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-176"
  ]
}
```

```lean
theorem centralmomentum :
  ∀ {N d : ℕ}
    (m : CoordinateMasses (N * d)) (F : Force (N * d))
    (Q : Set (Position (N * d))) (a b : ℝ)
    (γ : ℝ → PhaseSpace (N * d))
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hFsum : ∀ q ∈ Q, ∀ c : Fin d,
      ∑ i : Fin N, F q (particleCoordinateEquiv N d (i, c)) = 0)
    (c : Fin d) (s t : ℝ)
    (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    totalMomentumCoordinate (γ s).2 c = totalMomentumCoordinate (γ t).2 c
```

### MD-1.7-CentralAngularMomentum

```json
{
  "source_id": "MD-1.7-CentralAngularMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "Moreover, viewing the $\\boldsymbol q_i$ as vectors in $\\mathbb R^3$ (with 0 as their third component),\n\\[\\boldsymbol q_i\\times\\frac\\partial{\\partial\\boldsymbol q_i}U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j)=-\\boldsymbol q_j\\times\\frac\\partial{\\partial\\boldsymbol q_j}U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j),\\]\nwhich implies\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\sum_{i=1}^N\\boldsymbol q_i\\times(m_i\\dot{\\boldsymbol q}_i)=0,\\]\nand tells us that the total angular momentum is also conserved.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "cross3为欧氏3D叉积；原文平面嵌入是特例，当前一般3D。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.centralangularmomentum",
  "extra_assumptions": [
    "真实位置和动量导数；反对称内力和沿位移方向中心力。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-177"
  ]
}
```

```lean
theorem centralangularmomentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    ∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t
```

### MD-1.7-CenterOfMassMotion

```json
{
  "source_id": "MD-1.7-CenterOfMassMotion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "This means that the system will translate and rotate at a constant rate in time.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "本条仅translation；rotation字面部分分开保留下一条。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.centerofmassmotion",
  "extra_assumptions": [
    "质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-178"
  ]
}
```

```lean
theorem centerofmassmotion :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (I : Set ℝ) (a : ℝ), IsOpen I → IsPreconnected I → a ∈ I →
    (∀ i, 0 < m i) → 0 < ∑ i, m i →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) →
    ∀ t ∈ I,
      (∑ i, m i)⁻¹ • (∑ i, m i • q t i) =
        (∑ i, m i)⁻¹ • (∑ i, m i • q a i) +
          (t-a) • ((∑ i, m i)⁻¹ • (∑ i, m i • v a i))
```

### MD-1.7-ConstantRotationLiteral

```json
{
  "source_id": "MD-1.7-ConstantRotationLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "This means that the system will translate and rotate at a constant rate in time.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "角动量常数不推出角速度常数；中心运动r变时θ̇=ℓ/r²。例r(t)=sqrt(1+t²),θ(t)=arctan t,ℓ=1。"
    }
  ],
  "lean_decl": "MD.Ch01.constantrotationliteral",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-179"
  ]
}
```

```lean
theorem constantrotationliteral :
  ∀ (r θ : ℝ → ℝ) (ℓ : ℝ),
    (∀ t, 0 < r t ∧ (r t)^2*deriv θ t = ℓ) →
    ∃ freq : ℝ, ∀ t, deriv θ t = freq
```

### MD-1.7-IsoscelesCoordinates

```json
{
  "source_id": "MD-1.7-IsoscelesCoordinates",
  "kind": "definition",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "Let us introduce new coordinates in the Lennard-Jones trimer as illustrated in Fig. 1.21, so that the center of mass is fixed at the origin: that is,\n\\[\\boldsymbol q_1=\\begin{bmatrix}x\\\\-y/3\\\\0\\end{bmatrix},\\qquad\\boldsymbol q_2=\\begin{bmatrix}-x\\\\-y/3\\\\0\\end{bmatrix},\\qquad\\boldsymbol q_3=\\begin{bmatrix}0\\\\2y/3\\\\0\\end{bmatrix},\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "单位质量；质心固定及等腰约束是特定对称初值，非所有零角动量三体配置。"
  ],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "同段“零平动/角动量→等腰”一般过强；这里只定义明确给定的对称配置，不把任意零动量当等腰。"
    }
  ],
  "lean_decl": "MD.Ch01.isoscelesCoordinates",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-180"
  ]
}
```

```lean
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
