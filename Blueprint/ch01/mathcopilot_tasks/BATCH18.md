# BATCH18：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：57, 58, 59；上下文读取该节相邻页。
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

### MD-1.6-RegularLatticeMinimizerLiteral

```json
{
  "source_id": "MD-1.6-RegularLatticeMinimizerLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6",
  "printed_page": "34",
  "pdf_page": "57",
  "statement_latex": "An obvious benefit of using periodic boundary conditions is that, with a uniform pair potential, the energy minimizers are points of a regular lattice; with confining potentials this is unlikely to be the case.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "对任意uniform φ断言规则格点极小不成立：φ=0时任何非均匀位置都最小；还缺势凸性、排斥、顺序/域资格。"
    }
  ],
  "lean_decl": "MD.Ch01.regularlatticeminimizerliteral",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-157"
  ]
}
```

```lean
theorem regularlatticeminimizerliteral :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ), 0 < L →
    ∀ x : Fin (N+1) → ℝ,
    (∀ y : Fin (N+1) → ℝ, boxPeriodicNearestNeighborPotentialEnergy φ L x ≤
      boxPeriodicNearestNeighborPotentialEnergy φ L y) →
    ∃ a : ℝ, regularLattice a (L/(N+1)) x
```

### MD-1.6-PeriodicImages

```json
{
  "source_id": "MD-1.6-PeriodicImages",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "35",
  "pdf_page": "58",
  "statement_latex": "periodic boundary conditions involve an extended potential energy of the form\n\\[U^{\\mathrm{pbc}}(\\boldsymbol q)=\\sum_{klm}\\sum_{i=1}^{N-1}\\sum_{j=i+1}^{N}\\varphi_{ij}(\\boldsymbol q_i,\\boldsymbol q_j+k\\boldsymbol v_1+l\\boldsymbol v_2+m\\boldsymbol v_3),\\]\nwhere $k,l,m$ run over $-1,0,1$ (in case interactions are restricted to the simulation cell and its immediate neighboring copies), and $\\boldsymbol v_i^T=(L\\boldsymbol e_i^T,\\ldots,L\\boldsymbol e_i^T)$, $i=1,2,3$, where $\\boldsymbol e_i$ is the $i$th Euclidean basis vector in $\\mathbb R^3$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "Fin3索引减1枚举-1,0,1；逐原子3向量加L(k,l,m)，等价全配置向量重复位移。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.periodicImageEnergy",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-158"
  ]
}
```

```lean
def periodicImageEnergy {N : ℕ} (L : ℝ) (φ : Fin N → Fin N → twoBodyTerms)
    (q : Fin N → V3) :=
  ∑ k : Fin 3, ∑ l : Fin 3, ∑ m : Fin 3, ∑ i, ∑ j ∈ Finset.Ioi i,
    φ i j (q i) (q j + WithLp.toLp 2 ![L*((k.val:ℝ)-1),L*((l.val:ℝ)-1),L*((m.val:ℝ)-1)])
```

### MD-1.6-MinimumImage

```json
{
  "source_id": "MD-1.6-MinimumImage",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "35",
  "pdf_page": "58",
  "statement_latex": "The minimum image convention states that, in computing the force, a given atom interacts only with the nearest replica of any other atom.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "L>0，minimumImage只定义最近复制体关系，不断言任意选择同一atom自作用。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.minimumImage",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-159"
  ]
}
```

```lean
def minimumImage (L : ℝ) (q r image : V3) : Prop :=
  ∃ k : Fin 3 → ℤ, image = r + WithLp.toLp 2 (fun i => L*k i) ∧
    ∀ l : Fin 3 → ℤ, ‖q-image‖ ≤ ‖q-(r+WithLp.toLp 2 (fun i => L*l i))‖
```

### MD-1.6-RhombicLattice

```json
{
  "source_id": "MD-1.6-RhombicLattice",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "35",
  "pdf_page": "58",
  "statement_latex": "In 2D, the typical geometry observed at low temperature is defined by a rhombic lattice, with sides of fixed length $n_x,n_y$ and the angle between them ($\\theta$), see Fig. 1.17.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "a=nx,b=ny；定义只编码基向量Z线性组合，不声称低温平衡一定如此。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.rhombicLattice",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-160"
  ]
}
```

```lean
def rhombicLattice (a b θ : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}
```

### MD-1.6-HexagonalLattice

```json
{
  "source_id": "MD-1.6-HexagonalLattice",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6",
  "printed_page": "35",
  "pdf_page": "58",
  "statement_latex": "it can be viewed as a rhombic lattice with $n_x=n_y$ and $\\theta=120^\\circ$; it can also be viewed as a rhombic lattice with $\\theta=60^\\circ$",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "Fig1.17图注；等长60°/120°两基给同一格。当前def采用60°；120°等价几何需独立证明不作为def存在假设。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hexagonal_lattice_two_bases",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-161"
  ]
}
```

```lean
theorem hexagonal_lattice_two_bases (a : ℝ) :
    rhombicLattice a a (2*Real.pi/3) = rhombicLattice a a (Real.pi/3)
```

### MD-1.6-UnitCell

```json
{
  "source_id": "MD-1.6-UnitCell",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "35",
  "pdf_page": "58",
  "statement_latex": "The unit cell is a description of the arrangement of atoms within a box; unit cells may be stacked in each direction to describe an atomic lattice.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "B为三基向量矩阵，motif为盒内点集；定义按整数平移重复。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.unitCellLattice",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-162"
  ]
}
```

```lean
def unitCellLattice (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Set V3 :=
  {q | ∃ k : Fin 3 → ℤ, ∃ u ∈ motif,
    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}
```

### MD-1.6-FCCStacking

```json
{
  "source_id": "MD-1.6-FCCStacking",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "36",
  "pdf_page": "59",
  "statement_latex": "The fcc lattice corresponds to the common arrangement by which cannonballs are stacked into pyramidal structures; it can be viewed as a periodic stacking (ABCABC. . . ) of three hexagonally structured planar layers, as illustrated in Fig. 1.18.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.fccStacking",
  "extra_assumptions": [
    "将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-164"
  ]
}
```

```lean
def fccStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 3
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

### MD-1.6-HCPStacking

```json
{
  "source_id": "MD-1.6-HCPStacking",
  "kind": "definition",
  "label": null,
  "section": "1.6",
  "printed_page": "36",
  "pdf_page": "59",
  "statement_latex": "Also shown in Fig. 1.18 is the hcp lattice, which, on the other hand, alternates two distinct planar lattices.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hcpStacking",
  "extra_assumptions": [
    "图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-165"
  ]
}
```

```lean
def hcpStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 2
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
