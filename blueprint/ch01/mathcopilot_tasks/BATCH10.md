# BATCH10：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：48, 49；上下文读取该节相邻页。
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

### MD-1.5-LocalExistUnique

```json
{
  "source_id": "MD-1.5-LocalExistUnique",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5",
  "printed_page": "25",
  "pdf_page": "48",
  "statement_latex": "One of the most important properties of a typical classical molecular Hamiltonian system is the existence and uniqueness of solutions started from a generic initial condition.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.local_exist_unique",
  "extra_assumptions": [
    "generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-089"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem local_exist_unique {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (hQ : IsOpen Q) (t₀ : ℝ) (z₀ : PhaseSpace n) (hz : z₀.1 ∈ Q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∃ ε γ, IsLocalMechanicalIVP m (fun q => -gradient U q) Q t₀ z₀ ε γ) ∧
    ∀ I γ η, IsOpen I → t₀ ∈ I →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I γ →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I η →
      γ t₀ = z₀ → η t₀ = z₀ → γ =ᶠ[𝓝 t₀] η
```

### MD-1.5-EnergySurface

```json
{
  "source_id": "MD-1.5-EnergySurface",
  "kind": "definition",
  "label": null,
  "section": "1.5",
  "printed_page": "25",
  "pdf_page": "48",
  "statement_latex": "For given $E_0\\geq U_{\\min}$ define $\\Sigma_{E_0}=\\{(\\boldsymbol q,\\boldsymbol p)\\mid H(\\boldsymbol q,\\boldsymbol p)=E_0\\}$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "Σ是指定H的能量层，E0≥Umin为使用背景，不声称层非空。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.energySurface",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-090"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def energySurface {n : ℕ} (H : PhaseSpace n → ℝ) (E : ℝ) := {z | H z = E}
```

### MD-1.5-EnergyBounds

```json
{
  "source_id": "MD-1.5-EnergyBounds",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5",
  "printed_page": "25",
  "pdf_page": "48",
  "statement_latex": "Assume that $U$ is a potential energy function which is bounded below, $U\\geq U_{\\min}$. For given $E_0\\geq U_{\\min}$ define $\\Sigma_{E_0}=\\{(\\boldsymbol q,\\boldsymbol p)\\mid H(\\boldsymbol q,\\boldsymbol p)=E_0\\}$. Then, for $(\\boldsymbol q,\\boldsymbol p)\\in\\Sigma_{E_0}$ we have\n\\[\\frac{\\boldsymbol p^T\\boldsymbol M^{-1}\\boldsymbol p}2+U(\\boldsymbol q)=E_0\\Rightarrow\\frac{\\boldsymbol p^T\\boldsymbol M^{-1}\\boldsymbol p}2=E_0-U(\\boldsymbol q)\\leq E_0-U_{\\min}.\\]\n$\\boldsymbol M^{-1}$ is a positive definite matrix (assumed here to be constant), so we can infer that the momenta are bounded at fixed total energy. We would like to say something similar for positions. We have, at energy $E_0$,\n\\[U_{\\min}\\leq U(\\boldsymbol q)\\leq E_0.\\]",
  "proof_latex": "Then, for $(\\boldsymbol q,\\boldsymbol p)\\in\\Sigma_{E_0}$ we have\n\\[\\frac{\\boldsymbol p^T\\boldsymbol M^{-1}\\boldsymbol p}2+U(\\boldsymbol q)=E_0\\Rightarrow\\frac{\\boldsymbol p^T\\boldsymbol M^{-1}\\boldsymbol p}2=E_0-U(\\boldsymbol q)\\leq E_0-U_{\\min}.\\]\n$\\boldsymbol M^{-1}$ is a positive definite matrix (assumed here to be constant), so we can infer that the momenta are bounded at fixed total energy. We would like to say something similar for positions. We have, at energy $E_0$,\n\\[U_{\\min}\\leq U(\\boldsymbol q)\\leq E_0.\\]",
  "proof_note": "原页能量不等式及正定推界论证逐字引用；与陈述合引部分保留，未添加原书没有的证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.energy_bounds",
  "extra_assumptions": [
    "U定义在整个欧氏位置域；保持一般常M⁻¹正定，未换成固定对角特例。"
  ],
  "repair_log": [
    {
      "stage": "LOCAL_RENDER_RECHECK",
      "reason": "重看PDF48补漏we have；将原页论证同时列入proof_latex。",
      "before_sha256": "9f6ec2e74844dd0cce30bf00f28ede9dfc17e7532d8e7f0f4216f7db3726b89d",
      "after_sha256": "84def7c6102bd8cd0852473f4092b9e1ce4e723e67d24688edf6712c8e1a32b4"
    }
  ],
  "old_ids": [
    "CH01-091",
    "CH01-092",
    "CH01-093"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem energy_bounds {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : ∀ q, Umin ≤ U q) :
    (∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ →
      inner ℝ p (matrixAction M⁻¹ p) / 2 = E₀ - U q ∧
      inner ℝ p (matrixAction M⁻¹ p) / 2 ≤ E₀ - Umin ∧ Umin ≤ U q ∧ U q ≤ E₀) ∧
    ∃ R : ℝ, ∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ → ‖p‖ ≤ R
```

### MD-1.5-UniformLevelsCompact

```json
{
  "source_id": "MD-1.5-UniformLevelsCompact",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5",
  "printed_page": "26",
  "pdf_page": "49",
  "statement_latex": "What is needed is an assumption that the level sets $\\widehat\\Sigma_\\alpha=\\{\\boldsymbol q\\mid U(\\boldsymbol q)=\\alpha\\}$ are bounded uniformly for $\\alpha\\in[U_{\\min},E_0]$. Then it follows that solutions satisfying the energy constraint remain confined to a compact (closed and bounded) set.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.uniform_levels_compact",
  "extra_assumptions": [
    "U连续保证能量层闭；一般常逆质量正定继承p.25；无奇异域的全欧氏模型，若有奇异域需紧集留域。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-094",
    "CH01-096"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem uniform_levels_compact {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : Continuous U) (hlower : ∀ q, Umin ≤ U q)
    (hlevels : ∃ R : ℝ, ∀ α ∈ Icc Umin E₀, ∀ q, U q = α → ‖q‖ ≤ R) :
    IsCompact {z : PhaseSpace n | variableMassHamiltonian (fun _ => M) U z.1 z.2 = E₀}
```

### MD-1.5-CompactContinuation

```json
{
  "source_id": "MD-1.5-CompactContinuation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5",
  "printed_page": "25–26",
  "pdf_page": "48–49",
  "statement_latex": "The uniqueness of solutions is easily verified in the usual way (as for the local result for uniqueness of solutions). The key point is that, with the energy constraint, solutions typically remain bounded for all time.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.compact_continuation",
  "extra_assumptions": [
    "共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-095"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem compact_continuation {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (K : Set (PhaseSpace n)) (z₀ : PhaseSpace n)
    (hQ : IsOpen Q) (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q) (hz : z₀ ∈ K)
    (hconfine : ∀ a b γ, 0 ∈ Ioo a b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ 0 = z₀ → ∀ t ∈ Ioo a b, γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q univ γ ∧ γ 0 = z₀ ∧ ∀ t, γ t ∈ K
```

### MD-1.5-Nonconfining

```json
{
  "source_id": "MD-1.5-Nonconfining",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5",
  "printed_page": "26",
  "pdf_page": "49",
  "statement_latex": "The assumption on $U$ is not satisfied by some simple potentials. For example consider $U(x,y)=x^2$ which is completely independent of $y$ and so places no restriction on that variable for constant energy.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.nonconfining",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-097"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem nonconfining :
  ¬ Bornology.IsBounded {q : Position 2 | (q 0)^2 = 1}
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
