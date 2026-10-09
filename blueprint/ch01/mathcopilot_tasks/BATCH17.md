# BATCH17：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：56, 57；上下文读取该节相邻页。
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

### MD-1.6-UniformPairLattice

```json
{
  "source_id": "MD-1.6-UniformPairLattice",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "33",
  "pdf_page": "56",
  "statement_latex": "Let us suppose we have a uniform pair potential $\\varphi$ and define the total potential energy of a system of N atoms by\n\\[U(x_1,x_2,\\ldots,x_N)=\\sum_{i=1}^{N-1}\\sum_{j=i+1}^{N}\\varphi(|x_i-x_j|).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.latticePairPotential",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-149"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def latticePairPotential {N : ℕ} (φ : ℝ → ℝ) (x : Fin N → ℝ) : ℝ :=
  ∑ i, ∑ j ∈ Finset.Ioi i, φ |x i-x j|
```

### MD-1.6-UnorderedPairCount

```json
{
  "source_id": "MD-1.6-UnorderedPairCount",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6",
  "printed_page": "33",
  "pdf_page": "56",
  "statement_latex": "The computation of the energy requires $N(N-1)/2$ separate calculations, which could be very expensive if N is large.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "只形式化无序pair计数；计算成本定性评价不作定理。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.unorderedpaircount",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-150"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem unorderedpaircount :
  ∀ N : ℕ, (Finset.univ.filter (fun p : Fin N × Fin N => p.1 < p.2)).card = N*(N-1)/2
```

### MD-1.6-NearestNeighbor

```json
{
  "source_id": "MD-1.6-NearestNeighbor",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "33",
  "pdf_page": "56",
  "statement_latex": "We can reduce this by assuming only nearest neighbor forces, which means the energy becomes\n\\[U(x_1,x_2,\\ldots,x_N)=\\sum_{i=1}^{N-1}\\varphi(|x_{i+1}-x_i|).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "Lean有N+1个site，对应原文N；加一避空首末索引，下同。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.nearestNeighborModel",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-151"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def nearestNeighborModel {N : ℕ} (φ : ℝ → ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  ∑ i : Fin N, φ |x i.succ-x i.castSucc|
```

### MD-1.6-WalledChain

```json
{
  "source_id": "MD-1.6-WalledChain",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "33",
  "pdf_page": "56",
  "statement_latex": "In order to keep such a system bounded we might then introduce walls at the ends of the chain, e.g. by adding confining potentials to $U$:\n\\[U(x_1,x_2,\\ldots,x_N)=\\varphi_c(|x_1|)+\\varphi_c(|L-x_N|)+\\sum_{i=1}^{N-1}\\varphi(|x_{i+1}-x_i|).\\tag{1.7}\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.walledChainModel",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-152"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def walledChainModel {N : ℕ} (φ φc : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  φc |x 0| + φc |L-x (Fin.last N)| + nearestNeighborModel φ x
```

### MD-1.6-PeriodicChain

```json
{
  "source_id": "MD-1.6-PeriodicChain",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "33",
  "pdf_page": "56",
  "statement_latex": "Alternatively one could restrict to a bounded domain by use of periodic boundary conditions, introducing the potential energy:\n\\[U(x_1,x_2,\\ldots,x_N)=\\sum_{i=1}^{N-1}\\varphi(|x_{i+1}-x_i|)+\\varphi(|L+x_1-x_N|).\\tag{1.8}\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.periodicChainModel",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-153"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def periodicChainModel {N : ℕ} (φ : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  nearestNeighborModel φ x + φ |L+x 0-x (Fin.last N)|
```

### MD-1.6-PeriodicBoundary

```json
{
  "source_id": "MD-1.6-PeriodicBoundary",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "34",
  "pdf_page": "57",
  "statement_latex": "If a particle moves to the right of $x=L$ we simply shift its position to $x-L$; likewise any particle exiting to the left of $x=0$ has its position shifted to $x+L$ (see Fig. 1.15).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "周期位置等价类：x与x+kL，k∈Z；实际越界wrap代表选择原文只给左右各一步。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.periodicBoundary",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-154"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def periodicBoundary (L : ℝ) (x y : ℝ) : Prop := ∃ k : ℤ, y = x + k*L
```

### MD-1.6-PeriodicTranslationMomentum

```json
{
  "source_id": "MD-1.6-PeriodicTranslationMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6",
  "printed_page": "34",
  "pdf_page": "57",
  "statement_latex": "Periodic boundary conditions allow us to preserve Newton’s third law, the translational symmetry, and thus the conservation of momentum.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "翻译不变模型作用的常向量方向导数零，使总内力零；动量守恒复用MomentumConservation条目。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.periodic_translation_momentum",
  "extra_assumptions": [
    "一维周期链真实Newton导数、正质量、势沿轨迹可微及开连通时间域。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-155"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem periodic_translation_momentum :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ),
    let U := boxPeriodicNearestNeighborPotentialEnergy φ L
    (∀ q c, U (fun i => q i+c) = U q) ∧
    (∀ q, DifferentiableAt ℝ U q → fderiv ℝ U q (fun _ => 1) = 0) ∧
    ∀ (m : Fin (N+1) → ℝ) (q v : ℝ → Fin (N+1) → ℝ) (I : Set ℝ),
      IsOpen I → IsPreconnected I → (∀ i, 0 < m i) →
      (∀ t ∈ I, DifferentiableAt ℝ U (q t)) →
      (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t ∧
        HasDerivAt (fun s => m i*v s i) (-fderiv ℝ U (q t) (Pi.single i 1)) t) →
      (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i*v s i) 0 t) ∧
      ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i*v a i) = ∑ i, m i*v b i
```

### MD-1.6-RegularLattice

```json
{
  "source_id": "MD-1.6-RegularLattice",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "34",
  "pdf_page": "57",
  "statement_latex": "On the line, we think of a (finite) lattice as a sequence of discrete points separated by a fixed distance $\\Delta x$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.regularLattice",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-156"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def regularLattice {N : ℕ} (a δ : ℝ) (x : Fin N → ℝ) : Prop :=
  0 < δ ∧ ∀ i, x i = a + i.val*δ
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
