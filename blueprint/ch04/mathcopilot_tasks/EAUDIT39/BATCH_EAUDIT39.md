# EAUDIT39：第4章§4.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4-WaterPairPotential",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "167",
  "pdf_page": "189",
  "statement_latex": "The potential energy for the interaction of a pair of such molecules, the sets of whose charge sites are denoted by $A$ and $B$, takes the form\n\\[\\varphi^{\\rm water-water}=\\sum_{i\\in A}\\sum_{j\\in B}\\frac{k_1Q_iQ_j}{r_{ij}}+\\frac{k_2}{r_{OO}^{12}}-\\frac{k_3}{r_{OO}^{6}},\\]\nwhere $r_{OO}$ represents the distance between the oxygen atoms of the two molecules, and $k_1,k_2,k_3$ are positive constants.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A、B为两分子电荷位点集合；TIP4P每分子有三个电荷位点（两个氢核及一个ghost位点）；Q_i为位点电荷，r_{ij}为位点间距离。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.waterPairPotential",
  "reusable_proofs": [],
  "extra_assumptions": [
    "有限电荷位点、所有距离>0与k1,k2,k3>0是物理定义域；不将经验模型当普遍物理定律。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:01:02.573179",
      "before_sha256": "eeb0d80682adf800ee0f7775e48f7080b97cdbcaf88bebbaa96340b14aa65442",
      "after_sha256": "cf9c173ab5940ce267532d1af0983043efa8349c38deaab8505920944e937a39",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def waterPairPotential {a b : ℕ} (k1 k2 k3 rOO : ℝ) (qa : Fin a → ℝ)
    (qb : Fin b → ℝ) (r : Fin a → Fin b → ℝ) : ℝ :=
  (∑ i, ∑ j, k1*qa i*qb j/r i j)+k2/rOO^12-k3/rOO^6
```
### 实际依赖 MD.Ch04.waterPairPotential
```lean
def waterPairPotential {a b : ℕ} (k1 k2 k3 rOO : ℝ) (qa : Fin a → ℝ)
    (qb : Fin b → ℝ) (r : Fin a → Fin b → ℝ) : ℝ :=
  (∑ i, ∑ j, k1*qa i*qb j/r i j)+k2/rOO^12-k3/rOO^6
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-CenterMass",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "167",
  "pdf_page": "189",
  "statement_latex": "The atomic positions may be referred to a coordinate system placed at the center of mass of the collection $q_{\\rm cm}=\\frac{\\sum_{i=1}^Nm_iq_i}{M}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "q_i为原子位置、m_i为其质量，M=∑_{i=1}^N m_i；q_cm为质心位置（物理适用域M>0）。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.centerMass",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:01:02.573339",
      "before_sha256": "696ec4ae28f3df0e62e686245745656844b51d3cd1b2d1f9b30c9c48720237c1",
      "after_sha256": "96a93c8455205448e64c2183900f9a1131a67d5a6e7914c585e218c26306b1ca",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  (MolecularDynamics.Chapter04Review.totalMass m)⁻¹ • ∑ i, m i • q i
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.totalMass
```lean
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.centerMass
```lean
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  (MolecularDynamics.Chapter04Review.totalMass m)⁻¹ • ∑ i, m i • q i
```
### 实际依赖 MD.Ch04.totalMass
```lean
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-RelativePositions",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "167",
  "pdf_page": "189",
  "statement_latex": "We write $q_i=q_{\\rm cm}+\\delta_i$, where $\\sum_{i=1}^Nm_i\\delta_i=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "δ_i=q_i-q_cm为相对质心的位置；原文同时给出∑_{i=1}^N m_i δ_i=0。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.relativePositions",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅q_i=q_cm+δ_i的相对位置定义；加权零和由MD-4.4-RelativeWeightedZero承担。"
  ],
  "statement_scope": "仅q_i=q_cm+δ_i的相对位置定义；加权零和由MD-4.4-RelativeWeightedZero承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:01:02.573449",
      "before_sha256": "3c902d1291500e398f7b8f8ab52400d0addf2923146aa59e6e5ff12cb0dd132e",
      "after_sha256": "6cdeddc82ce13112236a25859dfb4fe64cf7db049ba80e77e5864a83a376182c",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def relativePositions {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : Fin N → MolecularDynamics.Chapter04Review.V :=
  fun i => q i-MolecularDynamics.Chapter04Review.centerMass m q
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.centerMass
```lean
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → V) : V :=
  (totalMass m)⁻¹ • ∑ i, m i • q i
```
### 实际依赖 MolecularDynamics.Chapter04Review.totalMass
```lean
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.centerMass
```lean
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  (MolecularDynamics.Chapter04Review.totalMass m)⁻¹ • ∑ i, m i • q i
```
### 实际依赖 MD.Ch04.relativePositions
```lean
def relativePositions {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : Fin N → MolecularDynamics.Chapter04Review.V :=
  fun i => q i-MolecularDynamics.Chapter04Review.centerMass m q
```
### 实际依赖 MD.Ch04.totalMass
```lean
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-KineticSplit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "167",
  "pdf_page": "189",
  "statement_latex": "Thus the kinetic energy becomes\n\\[K=\\frac12\\sum_{i=1}^Nm_i\\|\\dot q_{\\rm cm}\\|^2+\\sum_{i=1}^Nm_i\\dot q_{\\rm cm}\\cdot\\dot\\delta_i+\\frac12\\sum_{i=1}^Nm_i\\|\\dot\\delta_i\\|^2\n=\\frac M2\\|\\dot q_{\\rm cm}\\|^2+\\frac12\\sum_{i=1}^Nm_i\\|\\dot\\delta_i\\|^2,\\]\nwhere we have used the fact that $\\sum_{i=1}^Nm_i\\delta_i\\equiv0$, hence that the time derivative also vanishes, in order to remove the middle term.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "点号表示时间导数；M=∑_{i=1}^N m_i，∑m_i δ_i恒为零；原文将两项分别记为K_trans和K_rot。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.kineticSplit",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:01:02.573552",
      "before_sha256": "b048541b91b64bb5a56898e8c3f13735551d3327565b17288a7ff170b375888a",
      "after_sha256": "9933d7a2d5b8f2e8d377daa725c0f29f7cf05ba8ec7eee52409c5900d9ff0949",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem kineticSplit :
  ∀ N (m : Fin N → ℝ) (v : MolecularDynamics.Chapter04Review.V) (w : Fin N → MolecularDynamics.Chapter04Review.V),
  (∑ i, m i • w i)=0 →
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i))/2=MolecularDynamics.Chapter04Review.totalMass m*MolecularDynamics.Chapter04Review.dot v v/2+(∑ i,m i*MolecularDynamics.Chapter04Review.dot (w i) (w i))/2 := by
  intro N m v w hz
  have h0 := congrFun hz 0
  have h1 := congrFun hz 1
  have h2 := congrFun hz 2
  simp only [Finset.sum_apply,Pi.smul_apply,smul_eq_mul,Pi.zero_apply] at h0 h1 h2
  have he : ∀ i, MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i)=
      MolecularDynamics.Chapter04Review.dot v v+2*MolecularDynamics.Chapter04Review.dot v (w i)+MolecularDynamics.Chapter04Review.dot (w i) (w i) := by
    intro i
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three]
    ring
  have ht : ∀ a : Fin 3, (∑ i, m i*(v a*w i a))=v a*∑ i,m i*w i a := by
    intro a
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  have hc : ∑ i, m i*MolecularDynamics.Chapter04Review.dot v (w i)=0 := by
    simp only [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,mul_add,Finset.sum_add_distrib]
    rw [ht 0,ht 1,ht 2,h0,h1,h2]
    ring
  simp_rw [he,mul_add,Finset.sum_add_distrib]
  rw [← Finset.sum_mul]
  have hx : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=0 := by
    rw [show (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=2*∑ i,m i*MolecularDynamics.Chapter04Review.dot v (w i) by rw [Finset.mul_sum]; apply Finset.sum_congr rfl; intro i hi; ring,hc,mul_zero]
  rw [hx]
  simp [MolecularDynamics.Chapter04Review.totalMass]
  ring
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.totalMass
```lean
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
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
### 实际依赖 MD.Ch04.totalMass
```lean
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-SecondMoment",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "where the fixed matrix $R$ is given by $R=\\sum_{i=1}^Nm_i\\delta_i(0)\\delta_i(0)^T$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "δ_i(0)为固定初始相对位置；R为其质量加权外积和所得3×3矩阵。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.secondMoment",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:01:02.573648",
      "before_sha256": "2cc948859fd000bfe6d732f711e5be0802c4baef81d82e1c22dae5a45a0e7f70",
      "after_sha256": "6e71bc2694dc649dbfa08d73f7f234eda8ca417d1ae3f10a891054daf5e3ffdf",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := ∑ i, m i • MolecularDynamics.Chapter04Review.outer (δ i)
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
  "source_id": "MD-4.4-RotationKinetic",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "$K_{\\rm rot}=\\frac12\\sum_{i=1}^Nm_i\\delta_i(0)^T\\dot\\Theta^T\\dot\\Theta\\delta_i(0)$. This expression may be rewritten as $K_{\\rm rot}=\\frac12\\operatorname{Tr}[\\dot\\Theta R\\dot\\Theta^T]$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Θ(t)为正交3×3旋转矩阵，δ_i(t)=Θ(t)δ_i(0)；R=∑m_iδ_i(0)δ_i(0)^T。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationKinetic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅旋转动能trace定义；粒子有限和及两式等价由MD-4.4-RotationTraceIdentity承担。"
  ],
  "statement_scope": "仅旋转动能trace定义；粒子有限和及两式等价由MD-4.4-RotationTraceIdentity承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:01:02.573741",
      "before_sha256": "a50f327325d4431e607b166f0dd4db818e1b3066ee21a54cecee3f9b35e73313",
      "after_sha256": "b32ee2b8a088c15b80e519f5732b82089060325490f5e37c2c2bd12eb3def7e9",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rotationKinetic (R dΘ : MolecularDynamics.Chapter04Review.Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MD.Ch04.rotationKinetic
```lean
def rotationKinetic (R dΘ : MolecularDynamics.Chapter04Review.Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-RotationTraceIdentity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "$K_{\\rm rot}=\\frac12\\sum_{i=1}^Nm_i\\delta_i(0)^T\\dot\\Theta^T\\dot\\Theta\\delta_i(0)$. This expression may be rewritten as $K_{\\rm rot}=\\frac12\\operatorname{Tr}[\\dot\\Theta R\\dot\\Theta^T]$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF190（印刷168）：δ_i(t)=Θ(t)δ_i(0)，Θ(t)为3×3正交矩阵，δ_i(0)为固定参考相对位置，m_i为粒子质量。",
    "R=∑_{i=1}^N m_i δ_i(0)δ_i(0)^T 为固定矩阵；Tr为矩阵迹，dot Θ为时间导数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationTraceIdentity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:01:02.573831",
      "before_sha256": "14e621a0b3c8914ff9050d85c5e5178df72c296cb4e94a8d0e244b246a374588",
      "after_sha256": "9bf9000b899e0ac019ccb28ca36226b3b598139e80e4b04b9bbed10f3908fcd1",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem rotationTraceIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (dΘ : MolecularDynamics.Chapter04Review.Mat3),
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (dΘ *ᵥ δ i) (dΘ *ᵥ δ i))/2=
      MolecularDynamics.Chapter04Review.rotationKinetic (MolecularDynamics.Chapter04Review.secondMoment m δ) dΘ := by
  intro N m δ dΘ
  unfold MolecularDynamics.Chapter04Review.rotationKinetic MolecularDynamics.Chapter04Review.secondMoment
  rw [Matrix.mul_sum,Matrix.sum_mul,Matrix.trace_sum]
  rw [Finset.sum_div,Finset.sum_div]
  apply Finset.sum_congr rfl
  intro i hi
  simp [Matrix.trace,Matrix.mul_apply,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
  ring
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
### 实际依赖 MolecularDynamics.Chapter04Review.rotationKinetic
```lean
def rotationKinetic (R dΘ : Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2
```
### 实际依赖 MolecularDynamics.Chapter04Review.secondMoment
```lean
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → V) : Mat3 := ∑ i, m i • outer (δ i)
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
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```
### 实际依赖 MD.Ch04.rotationKinetic
```lean
def rotationKinetic (R dΘ : MolecularDynamics.Chapter04Review.Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2
```
### 实际依赖 MD.Ch04.secondMoment
```lean
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := ∑ i, m i • MolecularDynamics.Chapter04Review.outer (δ i)
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-RotationSkew",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168–169",
  "pdf_page": "190–191",
  "statement_latex": "Moreover, since $\\Theta\\Theta^T=I$, we have $\\dot\\Theta\\Theta^T+\\Theta\\dot\\Theta^T=0$, which indicates that $\\dot\\Theta\\Theta^T$ is a skew symmetric matrix.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF190–191（印刷168–169）：Θ(t)是可微正交矩阵轨道，ΘΘ^T=I为轨道约束，dot Θ为时间导数；上标T为转置。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationSkew",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实HasDerivAt矩阵轨道与邻域正交约束；不假设导数乘积恒等式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:01:02.573926",
      "before_sha256": "23b23b74a43f9a663a723747346a8b7598ac71ee84693c94784575a923055bf6",
      "after_sha256": "b0e090c93c63bb1337fd1c057812d2ae37ab06c56446f2345514416e05758f05",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem rotationSkew :
  ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) t d,
  HasDerivAt Θ d t → (∀ᶠ s in 𝓝 t, Θ s*(Θ s)ᵀ=1) → (d*(Θ t)ᵀ)ᵀ=-(d*(Θ t)ᵀ) := by
  intro Θ t d hd ho
  have hs : ∀ i j : Fin 3, ∑ k, (d i k*Θ t j k+Θ t i k*d j k)=0 := by
    intro i j
    have hf : HasDerivAt (fun s => ∑ k, Θ s i k*Θ s j k)
        (∑ k, (d i k*Θ t j k+Θ t i k*d j k)) t := by
      apply HasDerivAt.fun_sum
      intro k hk
      exact ((hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) k).mul (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd j) k))
    have he : (fun s => ∑ k, Θ s i k*Θ s j k) =ᶠ[𝓝 t] (fun _ => (1 : MolecularDynamics.Chapter04Review.Mat3) i j) := by
      filter_upwards [ho] with s h
      simpa [Matrix.mul_apply,Matrix.transpose_apply] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) h
    exact hf.unique ((hasDerivAt_const t ((1 : MolecularDynamics.Chapter04Review.Mat3) i j)).congr_of_eventuallyEq he)
  ext i j
  have h := hs i j
  simp only [Fin.sum_univ_three] at h
  simp [Matrix.mul_apply,Matrix.transpose_apply,Fin.sum_univ_three]
  nlinarith [h]
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
