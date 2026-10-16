# EAUDIT85：第4章§4.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4-DipolarHamiltonian",
  "kind": "definition",
  "label": "Example 4.1",
  "section": "4.4",
  "printed_page": "169–170",
  "pdf_page": "191–192",
  "statement_latex": "Example 4.1 (Dipolar Molecular Liquid) The Hamiltonian for a more general dipolar system can be written\n\\[H=K_{\\rm rot}(\\pi_1,\\ldots,\\pi_N)+K_{\\rm trans}(p_1,\\ldots,p_N)+U(q_1,\\ldots,q_N,\\mu_1,\\ldots,\\mu_N).\\]\nThe vectors $\\mu_k$ can be taken to be unit vectors reflecting the dipole orientation, so they are subject to the constraint $\\|\\mu_k\\|\\equiv1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文假设 identical ellipsoids；共同主惯性矩为 I₁,I₂,I₃。",
    "π_i 为体坐标角动量，p_i 为平移动量，q_i 为位置；μ_i 为单位偶极方向，‖μ_i‖≡1。",
    "PDF192给出 K_rot=1/2∑_{i=1}^N(π_{i,1}²/I₁+π_{i,2}²/I₂+π_{i,3}²/I₃)。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.dipolarHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "所有质量/主惯性矩>0，单位偶极方向为物理约束；N有限。",
    "[EXTRA] 真实物理接口补质量/主惯性正性和每个μ单位长度；πbody明确为体坐标角动量，数值公式不变。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:03:23.692021",
      "before_sha256": "97df381d0c7a7802c6cdab064b3fae18c099e4aad2df0c5721f0ebd5a5cbb990",
      "after_sha256": "1ad0912255c5857d17d7ee5b08a55702777f60b79e5d761a96a8beb6e1784a81",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def dipolarHamiltonian {N : ℕ} (mass : Fin N → ℝ) (inertia : MolecularDynamics.Chapter04Review.V) (_hm : ∀ i, 0 < mass i) (_hI : ∀ j, 0 < inertia j)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.V) → ℝ)
    (q p μ πbody : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hμ : ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1) : ℝ :=
  (∑ i, ∑ j, (πbody i j)^2/(2*inertia j))+(∑ i, MolecularDynamics.Chapter04Review.dot (p i) (p i)/(2*mass i))+U q μ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.dipolarHamiltonian
```lean
def dipolarHamiltonian {N : ℕ} (mass : Fin N → ℝ) (inertia : MolecularDynamics.Chapter04Review.V) (_hm : ∀ i, 0 < mass i) (_hI : ∀ j, 0 < inertia j)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.V) → ℝ)
    (q p μ πbody : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hμ : ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1) : ℝ :=
  (∑ i, ∑ j, (πbody i j)^2/(2*inertia j))+(∑ i, MolecularDynamics.Chapter04Review.dot (p i) (p i)/(2*mass i))+U q μ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.mass
```lean
def mass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => m i * v i
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-DipolarPairPotential",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170",
  "pdf_page": "192",
  "statement_latex": "The total dipole-dipole interaction potential then takes the form $\\varphi^{\\rm dip}_{ij}=\\varphi_{\\rm LJ}(r_{ij})+\\mu_i^TL(q_{ij})\\mu_j$, with $U$ given as the sum of these over pairs. The $3\\times3$ matrix $L$ is given by\n\\[L(q_{ij})=\\frac1{r_{ij}^3}I-\\frac3{r_{ij}^5}q_{ij}q_{ij}^T,\\qquad q_{ij}=q_i-q_j.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF 原式 L 的首项为标量 1/r_{ij}³；因 L 为3×3矩阵，该项表示 (1/r_{ij}³)I，JSON 显式补出 I。",
    "q_{ij}=q_i−q_j；r_{ij} 为其欧氏长度；U 为非重复粒子对的相互作用和。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.dipolarPairPotential",
  "reusable_proofs": [],
  "extra_assumptions": [
    "r=Euclidean距离>0；本条实际pair函数，不声称经验模型准确性。",
    "[EXTRA] 保留代数核；新增实际非碰撞粒子对q_i−q_j、r_ij=√(r·r)实例和仅i<j的完整系统势能求和，避免任意r与q脱钩。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:03:23.692073",
      "before_sha256": "32c83b3f8981a17a7b38b32c808e9f65f0ef51976a736d0e4bf7d388eb65daa3",
      "after_sha256": "5fcf69e246485b0fb85613e22771a63f2840b213e88c0565e11161800ce9c997",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def dipolarPairPotential (lj : ℝ → ℝ) (r : ℝ) (q μ ν : MolecularDynamics.Chapter04Review.V) : ℝ :=
  lj r+MolecularDynamics.Chapter04Review.dot μ (((r^3)⁻¹ • (1 : MolecularDynamics.Chapter04Review.Mat3)-(3/r^5) • MolecularDynamics.Chapter04Review.outer q) *ᵥ ν)

def dipolarPairPotential_particles {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V) (i j : Fin N)
    (_hij : i ≠ j) (_hnoncollision : q i ≠ q j) : ℝ :=
  let r := q i-q j
  dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot r r)) r (μ i) (μ j)

def dipolarSystemPotential {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hnoncollision : ∀ i j, i ≠ j → q i ≠ q j) : ℝ :=
  ∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i<j),
    let r := q i-q j
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot r r)) r (μ i) (μ j)
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.dipolarPairPotential
```lean
def dipolarPairPotential (lj : ℝ → ℝ) (r : ℝ) (q μ ν : MolecularDynamics.Chapter04Review.V) : ℝ :=
  lj r+MolecularDynamics.Chapter04Review.dot μ (((r^3)⁻¹ • (1 : MolecularDynamics.Chapter04Review.Mat3)-(3/r^5) • MolecularDynamics.Chapter04Review.outer q) *ᵥ ν)
```
### 实际依赖 MD.Ch04.dipolarPairPotential_particles
```lean
def dipolarPairPotential_particles {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V) (i j : Fin N)
    (_hij : i ≠ j) (_hnoncollision : q i ≠ q j) : ℝ :=
  let r := q i-q j
  dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot r r)) r (μ i) (μ j)
```
### 实际依赖 MD.Ch04.dipolarSystemPotential
```lean
def dipolarSystemPotential {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hnoncollision : ∀ i j, i ≠ j → q i ≠ q j) : ℝ :=
  ∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i<j),
    let r := q i-q j
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot r r)) r (μ i) (μ j)
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-RigidHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170–171",
  "pdf_page": "192–193",
  "statement_latex": "The Hamiltonian is (for a single rigid body):\n\\[H_{\\rm RB}=\\frac{\\|p_{\\rm cm}\\|^2}{2M}+\\frac{\\operatorname{Tr}[\\Pi R^{-1}\\Pi^T]}2+U(q_{\\rm cm},\\Theta),\\]\nsubject to the orthogonality constraint $\\Theta^T\\Theta=I$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "M是刚体总质量；q_cm、p_cm为质心位置和动量；Θ、Π是3×3矩阵，Θ表示方向，Π为其共轭动量。",
    "R=Σ_i m_i δ_i(0)δ_i(0)^T 是固定的二阶矩矩阵；U依赖质心位置及刚体方向。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "M>0、R非奇异是物理资格；正交约束单列在真实ODE关系中；inverse定义不计存在理论。",
    "[EXTRA] 主接口增加M>0、R可逆及ΘᵀΘ=I的实际受约束域，公式不再将任意矩阵姿态当刚体状态。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:03:23.692155",
      "before_sha256": "5b4d296d4ec5b5be43f9daa6dccba32eba16b8b2d9aba420b10109e5cfc1b685",
      "after_sha256": "deb2d942164212529ce06422826e81280efd430536d1a07763a18a317cc4d6c3",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EDITORIAL_METADATA_VISUAL_REVIEW",
      "timestamp": "2026-10-16T10:27:39.597807",
      "before_sha256": "deb2d942164212529ce06422826e81280efd430536d1a07763a18a317cc4d6c3",
      "after_sha256": "af3bebb4c6dfa8ac6801b4f4b6bfc71ed2f5e1fdd7546e94f82f97166208ddcd",
      "changed_fields": [
        "printed_page",
        "pdf_page"
      ],
      "changes": {
        "printed_page": {
          "before": "170",
          "after": "170–171"
        },
        "pdf_page": {
          "before": "192",
          "after": "192–193"
        }
      },
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH23_result.json",
      "reason": "已对照原页标题、展示式与跨页续文；合并页码/标签/原文类别，原文/签名及既有statement_scope不变。移出的相邻推导页明确保留为review_context_pdf_pages，不裁定数学疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/METADATA_REVIEW_20261016.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rigidHamiltonian (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (_hM : 0 < M) (_hR : R.det ≠ 0) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q p : MolecularDynamics.Chapter04Review.V) (Θ mom : MolecularDynamics.Chapter04Review.Mat3) (_hΘ : Θᵀ*Θ=1) : ℝ :=
  MolecularDynamics.Chapter04Review.dot p p/(2*M)+(mom*R⁻¹*momᵀ).trace/2+U q Θ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MD.Ch04.rigidHamiltonian
```lean
def rigidHamiltonian (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (_hM : 0 < M) (_hR : R.det ≠ 0) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q p : MolecularDynamics.Chapter04Review.V) (Θ mom : MolecularDynamics.Chapter04Review.Mat3) (_hΘ : Θᵀ*Θ=1) : ℝ :=
  MolecularDynamics.Chapter04Review.dot p p/(2*M)+(mom*R⁻¹*momᵀ).trace/2+U q Θ
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-SecondMomentDiagonal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "By choosing an appropriate coordinate frame, it is possible to insure that the symmetric matrix $R$ is a diagonal matrix.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "R=Σ_{i=1}^N m_i δ_i(0)δ_i(0)^T；δ_i(0)是固定参考构形中相对质心的位置向量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.secondMomentDiagonal",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:03:23.692195",
      "before_sha256": "e256e48c6794596e47fb9487e9dafabe884036303598675055160fa69ba1e4b2",
      "after_sha256": "b639b4ac75e5cf5b184a24f13115dfd16ae358b24b9f7a6bf2a50e23895819be",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem secondMomentDiagonal : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
    ∃ O : MolecularDynamics.Chapter04Review.Mat3, Oᵀ*O=1 ∧ ∀ i j, i ≠ j →
      (Oᵀ*MolecularDynamics.Chapter04Review.secondMoment m δ*O) i j=0 := by
  intro N m δ
  let R := MolecularDynamics.Chapter04Review.secondMoment m δ
  have hs : R.IsHermitian := by
    change Rᴴ=R
    ext i j
    simp [R,MolecularDynamics.Chapter04Review.secondMoment,MolecularDynamics.Chapter04Review.outer,Matrix.conjTranspose_apply,Matrix.sum_apply,Matrix.smul_apply,mul_comm]
  let O := hs.eigenvectorUnitary
  refine ⟨(O : MolecularDynamics.Chapter04Review.Mat3),?_,?_⟩
  · simpa [Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using Unitary.coe_star_mul_self O
  · have he : (O : MolecularDynamics.Chapter04Review.Mat3)ᵀ*R*(O : MolecularDynamics.Chapter04Review.Mat3)=Matrix.diagonal hs.eigenvalues := by
      simpa [O,Unitary.conjStarAlgAut_star_apply,Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using hs.conjStarAlgAut_star_eigenvectorUnitary
    intro i j hij
    simpa [Matrix.diagonal,hij] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) he
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```
### 实际依赖 MolecularDynamics.Chapter04Review.secondMoment
```lean
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → V) : Mat3 := ∑ i, m i • outer (δ i)
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```
### 实际依赖 MD.Ch04.secondMoment
```lean
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := ∑ i, m i • MolecularDynamics.Chapter04Review.outer (δ i)
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-RotationBodyEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "It is convenient to express this in terms of the so-called body angular velocity $\\omega_b=\\Theta^T\\omega$ in which case it becomes $K_{\\rm rot}=\\frac12\\omega_b^TT\\omega_b$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "δ_i(t)=Θ(t)δ_i(0)，Θ为正交旋转矩阵；空间角速度满足 dotδ_i=ω×δ_i。",
    "ω_b=Θ^Tω；T=Σ_i m_i[||δ_i(0)||²I−δ_i(0)δ_i(0)^T]，为体坐标系中的惯性张量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationBodyEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实SO3旋转；不把动能等式/叉积协变当假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:03:23.692233",
      "before_sha256": "732932102fd946afad60ee218b6b7bf18cbf1fa52d62a71e79532ce4b3c41ed6",
      "after_sha256": "2feeb662431e596d6d163d7c121128d4f95bcc69661f7578f16de42570c263ce",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem rotationBodyEnergy : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 →
  (∑ i, m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
    MolecularDynamics.Chapter04Review.rotationalEnergy (MolecularDynamics.Chapter04Review.inertiaTensor m δ) (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  let x := Θᵀ *ᵥ «ω»
  have ht : ∀ (A : MolecularDynamics.Chapter04Review.Mat3) (v w : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot (A *ᵥ v) w=MolecularDynamics.Chapter04Review.dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hx : Θ *ᵥ x=«ω» := by
    dsimp [x]
    rw [Matrix.mulVec_mulVec,mul_eq_one_comm.mp ho,Matrix.one_mulVec]
  have hn : MolecularDynamics.Chapter04Review.dot «ω» «ω»=MolecularDynamics.Chapter04Review.dot x x := by
    conv_lhs => rw [← hx]
    rw [ht,hi]
  have hc : ∀ v w : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 w v) (MolecularDynamics.Chapter04Review.cross3 w v)=MolecularDynamics.Chapter04Review.dot v v*MolecularDynamics.Chapter04Review.dot w w-(MolecularDynamics.Chapter04Review.dot v w)^2 := by
    intro v w
    simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three]
    ring
  have he : ∀ v y : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot y ((MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ y)=MolecularDynamics.Chapter04Review.dot v v*MolecularDynamics.Chapter04Review.dot y y-(MolecularDynamics.Chapter04Review.dot v y)^2 := by
    intro v y
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hf : ∀ v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v))=
      MolecularDynamics.Chapter04Review.dot x ((MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ x) := by
    intro v
    rw [hc,he]
    have hv : MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) (Θ *ᵥ v)=MolecularDynamics.Chapter04Review.dot v v := by rw [ht,hi]
    have hw : MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) «ω»=MolecularDynamics.Chapter04Review.dot v x := ht Θ v «ω»
    rw [hv,hn,hw]
  have hsum : ∀ (K : ℕ) (a : Fin K → MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot x (∑ i,a i)=∑ i,MolecularDynamics.Chapter04Review.dot x (a i) := by
    intro K a
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Finset.sum_apply,Finset.mul_sum,Finset.sum_add_distrib]
  have hsmul : ∀ (c : ℝ) (v : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot x (c • v)=c*MolecularDynamics.Chapter04Review.dot x v := by
    intro c v
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  rw [MolecularDynamics.Chapter04Review.rotationalEnergy,MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.sum_mulVec]
  change (∑ i,m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
      MolecularDynamics.Chapter04Review.dot x (∑ i,(m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))) *ᵥ x)/2
  simp_rw [Matrix.smul_mulVec]
  rw [hsum]
  simp_rw [hsmul,hf]
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.cross3
```lean
def cross3 (u v : V) : V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.inertiaTensor
```lean
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → V) : Mat3 :=
  ∑ i, m i • (dot (δ i) (δ i) • (1 : Mat3)-outer (δ i))
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```
### 实际依赖 MolecularDynamics.Chapter04Review.rotationalEnergy
```lean
def rotationalEnergy (T : Mat3) (ω : V) : ℝ := dot ω (T *ᵥ ω)/2
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MD.Ch04.inertiaTensor
```lean
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 :=
  ∑ i, m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```
### 实际依赖 MD.Ch04.rotationalEnergy
```lean
def rotationalEnergy (T : MolecularDynamics.Chapter04Review.Mat3) (ωb : MolecularDynamics.Chapter04Review.V) : ℝ := MolecularDynamics.Chapter04Review.dot ωb (T *ᵥ ωb)/2
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-DipolarConstraint",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170",
  "pdf_page": "192",
  "statement_latex": "The vectors $\\mu_k$ can be taken to be unit vectors reflecting the dipole orientation, so they are subject to the constraint $\\|\\mu_k\\|\\equiv1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "μ_k为第k个刚体偶极子的单位方向向量；||·||为三维欧氏范数，其模长恒为1。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.dipolarConstraint",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:03:23.692272",
      "before_sha256": "1ab37c138c963cdbe68679ec47089350159d38c6a150b7052be6099f824f51cd",
      "after_sha256": "99c094e96c92bee58bb8eb182759248f83047c4e8dc5ac5a707fc342a2c7c922",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def dipolarConstraint {N : ℕ} (μ : Fin N → MolecularDynamics.Chapter04Review.V) : Prop :=
  ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.dipolarConstraint
```lean
def dipolarConstraint {N : ℕ} (μ : Fin N → MolecularDynamics.Chapter04Review.V) : Prop :=
  ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-DipolarPotentialSum",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170",
  "pdf_page": "192",
  "statement_latex": "$\\varphi^{\\rm dip}_{ij}=\\varphi_{\\rm LJ}(r_{ij})+\\mu_i^TL(q_{ij})\\mu_j$, with $U$ given as the sum of these over pairs.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "q_ij=q_i−q_j，r_ij=||q_ij||为欧氏距离；μ_i、μ_j为单位偶极方向。",
    "原PDF写 L(q_ij)=1/r_ij³−(3/r_ij⁵)q_ij q_ij^T，并称L为3×3矩阵；首项按标量乘单位矩阵理解，原式未显式印I。",
    "U是所有不同粒子无序配对的相互作用势之和；φ_LJ为Lennard–Jones径向势，使用r_ij>0的无重叠构形。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.dipolarPotentialSum",
  "reusable_proofs": [],
  "extra_assumptions": [
    "对无重叠位置，真实Euclidean距离sqrtΣ(qi−qj)²及有限无序pair和；经验势定义，不计模拟正确性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:04:11.964101",
      "before_sha256": "0b9ca44fa171ddd8d3ac4cff0327df07d663d3132e416517af5ee3f8f86a78f7",
      "after_sha256": "311814d1b2f52872358595211eeb815243a20426bccc51a2a3edd76c6b2674ab",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def dipolarPotentialSum {N : ℕ} (lj : ℝ → ℝ) (q μ : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  ∑ i, ∑ j, if i < j then
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot (q i-q j) (q i-q j))) (q i-q j) (μ i) (μ j) else 0
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.dipolarPairPotential
```lean
def dipolarPairPotential (lj : ℝ → ℝ) (r : ℝ) (q μ ν : MolecularDynamics.Chapter04Review.V) : ℝ :=
  lj r+MolecularDynamics.Chapter04Review.dot μ (((r^3)⁻¹ • (1 : MolecularDynamics.Chapter04Review.Mat3)-(3/r^5) • MolecularDynamics.Chapter04Review.outer q) *ᵥ ν)
```
### 实际依赖 MD.Ch04.dipolarPotentialSum
```lean
def dipolarPotentialSum {N : ℕ} (lj : ℝ → ℝ) (q μ : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  ∑ i, ∑ j, if i < j then
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot (q i-q j) (q i-q j))) (q i-q j) (μ i) (μ j) else 0
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-RotationTrajectory",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "$\\delta_i(t)=\\Theta(t)\\delta_i(0)$, see Fig. 4.7, thus we have\n\\[K_{\\rm rot}=\\frac12\\sum_{i=1}^N m_i\\delta_i(0)^T\\dot\\Theta^T\\dot\\Theta\\delta_i(0).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "δ_i(t)为相对质心的位置，δ_i(0)为参考构形；Θ(t)为3×3正交方向矩阵，m_i为各粒子质量，dotΘ为时间导数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationTrajectory",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅δ_i(t)=Θ(t)δ_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。"
  ],
  "statement_scope": "仅δ_i(t)=Θ(t)δ_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:04:11.964235",
      "before_sha256": "7891f694c7c894b513cb1c2d42c2248951f436beba14c299ef1086a8bb5fa65f",
      "after_sha256": "cb836426bafa8d6c344a9da79b2f35bcb7a0d4e8aeca77236a0e334cb7553b7b",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem rotationTrajectory : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → HasDerivAt (fun s => Θ s *ᵥ δ) (d *ᵥ δ) t := by
  intro Θ d δ t hd
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,d i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  exact hasDerivAt_pi.mpr he
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
