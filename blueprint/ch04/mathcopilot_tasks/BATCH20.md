# BATCH20 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4-WaterPairPotential
```json
{
  "source_id": "MD-4.4-WaterPairPotential",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "167",
  "pdf_page": "189",
  "statement_latex": "the interaction of two water molecules, the sets of whose charge sites are denoted by $A$ and $B$, takes the form\n\\[\\varphi_{\\rm water}=\\sum_{i\\in A}\\sum_{j\\in B}\\frac{k_1Q_iQ_j}{r_{ij}}+\\frac{k_2}{r_{OO}^{12}}-\\frac{k_3}{r_{OO}^{6}},\\]\nwhere $r_{OO}$ represents the distance between the oxygen atoms of the two molecules, and $k_1,k_2,k_3$ are positive constants.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.waterPairPotential",
  "reusable_proofs": [],
  "extra_assumptions": [
    "有限电荷位点、所有距离>0与k1,k2,k3>0是物理定义域；不将经验模型当普遍物理定律。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def waterPairPotential {a b : ℕ} (k1 k2 k3 rOO : ℝ) (qa : Fin a → ℝ)
    (qb : Fin b → ℝ) (r : Fin a → Fin b → ℝ) : ℝ :=
  (∑ i, ∑ j, k1*qa i*qb j/r i j)+k2/rOO^12-k3/rOO^6
```

### MD-4.4-TotalMass
```json
{
  "source_id": "MD-4.4-TotalMass",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "167",
  "pdf_page": "189",
  "statement_latex": "where $M=\\sum_{i=1}^Nm_i$ is the total mass.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.totalMass",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
```

### MD-4.4-CenterMass
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
    "物理质量正，M>0；三维向量有限和。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.centerMass",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  (MolecularDynamics.Chapter04Review.totalMass m)⁻¹ • ∑ i, m i • q i
```

### MD-4.4-RelativePositions
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
    "加法关系直接由定义；加权零和另条真实证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.relativePositions",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def relativePositions {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : Fin N → MolecularDynamics.Chapter04Review.V :=
  fun i => q i-MolecularDynamics.Chapter04Review.centerMass m q
```

### MD-4.4-RelativeWeightedZero
```json
{
  "source_id": "MD-4.4-RelativeWeightedZero",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "167",
  "pdf_page": "189",
  "statement_latex": "We write $q_i=q_{\\rm cm}+\\delta_i$, where $\\sum_{i=1}^Nm_i\\delta_i=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.relativeWeightedZero",
  "reusable_proofs": [],
  "extra_assumptions": [
    "总质量非零；原物理正质量给此资格，空体系排除。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem relativeWeightedZero : ∀ N (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V),
    MolecularDynamics.Chapter04Review.totalMass m ≠ 0 → (∑ i, m i • MolecularDynamics.Chapter04Review.relativePositions m q i)=0
```

### MD-4.4-KineticSplit
```json
{
  "source_id": "MD-4.4-KineticSplit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "167",
  "pdf_page": "189",
  "statement_latex": "Thus the kinetic energy becomes\n\\[K=\\frac12\\sum_im_i\\|\\dot q_{\\rm cm}\\|^2+\\sum_im_i\\dot q_{\\rm cm}\\cdot\\dot\\delta_i+\\frac12\\sum_im_i\\|\\dot\\delta_i\\|^2\n=\\frac M2\\|\\dot q_{\\rm cm}\\|^2+\\frac12\\sum_im_i\\|\\dot\\delta_i\\|^2,\\]\nwhere we have used the fact that $\\sum_im_i\\delta_i\\equiv0$, hence that the time derivative also vanishes, in order to remove the middle term.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实有限坐标Euclidean平方；只假设加权相对速度和零，不假设能量分解。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.kineticSplit",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem kineticSplit :
  ∀ N (m : Fin N → ℝ) (v : MolecularDynamics.Chapter04Review.V) (w : Fin N → MolecularDynamics.Chapter04Review.V),
  (∑ i, m i • w i)=0 →
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i))/2=MolecularDynamics.Chapter04Review.totalMass m*MolecularDynamics.Chapter04Review.dot v v/2+(∑ i,m i*MolecularDynamics.Chapter04Review.dot (w i) (w i))/2
```

### MD-4.4-SecondMoment
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
    "真实参照体固定3×3对称二阶矩。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.secondMoment",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := ∑ i, m i • MolecularDynamics.Chapter04Review.outer (δ i)
```

### MD-4.4-RotationKinetic
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
    "保留1/2；有限和到trace的恒等式另列，定义不计该恒等式证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationKinetic",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rotationKinetic (R dΘ : MolecularDynamics.Chapter04Review.Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2
```

