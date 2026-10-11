# BATCH22 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4-CrossIdentityFull
```json
{
  "source_id": "MD-4.4-CrossIdentityFull",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$\\operatorname{skew}(\\omega)\\delta_i=\\omega\\times\\delta_i=-\\operatorname{skew}(\\delta_i)\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留三个表达式及两个等式；首等式的已证子引理另条，不以子引理冒充全部原式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.crossIdentityFull",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem crossIdentityFull : ∀ u v : MolecularDynamics.Chapter04Review.V,
    MolecularDynamics.Chapter04Review.skewMatrix u *ᵥ v=MolecularDynamics.Chapter04Review.cross3 u v ∧
    MolecularDynamics.Chapter04Review.cross3 u v= -(MolecularDynamics.Chapter04Review.skewMatrix v *ᵥ u)
```

### MD-4.4-RotationalEnergy
```json
{
  "source_id": "MD-4.4-RotationalEnergy",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "It is convenient to express this in terms of the so-called body angular velocity $\\omega_b=\\Theta^T\\omega$ in which case it becomes $K_{\\rm rot}=\\frac12\\omega_b^TT\\omega_b$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationalEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rotationalEnergy (T : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V) : ℝ := MolecularDynamics.Chapter04Review.dot «ω» (T *ᵥ «ω»)/2
```

### MD-4.4-InertiaSkewIdentity
```json
{
  "source_id": "MD-4.4-InertiaSkewIdentity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$T=-\\sum_{i=1}^Nm_i\\operatorname{skew}(\\delta_i(0))^2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.inertiaSkewIdentity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem inertiaSkewIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.inertiaTensor m δ= -∑ i, m i • (MolecularDynamics.Chapter04Review.skewMatrix (δ i))^2
```

### MD-4.4-InertiaTracePrinted
```json
{
  "source_id": "MD-4.4-InertiaTracePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "This matrix is closely related to the matrix $R$:\n\\[R=\\sum_im_i\\delta_i\\delta_i^T=\\sum_im_i\\|\\delta_i\\|^2I-T=(T_{11}+T_{22}+T_{33})I-T.\\tag{4.40}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "(4.40)末式应trace(T)/2 I−T；原式逐字保留。"
    }
  ],
  "lean_decl": "MD.Ch04.inertiaTracePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem inertiaTracePrinted :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=(MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ
```

### MD-4.4-InertiaTraceCorrected
```json
{
  "source_id": "MD-4.4-InertiaTraceCorrected",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$R=\\sum_im_i\\delta_i\\delta_i^T=\\sum_im_i\\|\\delta_i\\|^2I-T$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.inertiaTraceCorrected",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]纠正(4.40)末式系数为trace(T)/2；不覆盖原印刷条目。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem inertiaTraceCorrected :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=((MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace/2) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ
```

### MD-4.4-DipolarHamiltonian
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
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.dipolarHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "所有质量/主惯性矩>0，单位偶极方向为物理约束；N有限。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def dipolarHamiltonian {N : ℕ} (mass : Fin N → ℝ) (inertia : MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.V) → ℝ)
    (q p μ π : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  (∑ i, ∑ j, (π i j)^2/(2*inertia j))+(∑ i, MolecularDynamics.Chapter04Review.dot (p i) (p i)/(2*mass i))+U q μ
```

### MD-4.4-DipolarPairPotential
```json
{
  "source_id": "MD-4.4-DipolarPairPotential",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170",
  "pdf_page": "192",
  "statement_latex": "The total dipole-dipole interaction potential then takes the form $\\varphi^{\\rm dip}_{ij}=\\varphi^{\\rm LJ}(r_{ij})+\\mu_i^TL(q_{ij})\\mu_j$, with $U$ given as the sum of these over pairs. The $3\\times3$ matrix $L$ is given by\n\\[L(q_{ij})=\\frac1{r_{ij}^3}I-\\frac3{r_{ij}^5}q_{ij}q_{ij}^T,\\qquad q_{ij}=q_i-q_j.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.dipolarPairPotential",
  "reusable_proofs": [],
  "extra_assumptions": [
    "r=Euclidean距离>0；本条实际pair函数，不声称经验模型准确性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def dipolarPairPotential (lj : ℝ → ℝ) (r : ℝ) (q μ ν : MolecularDynamics.Chapter04Review.V) : ℝ :=
  lj r+MolecularDynamics.Chapter04Review.dot μ (((r^3)⁻¹ • (1 : MolecularDynamics.Chapter04Review.Mat3)-(3/r^5) • MolecularDynamics.Chapter04Review.outer q) *ᵥ ν)
```

### MD-4.4-DipolarRotationalPrinted
```json
{
  "source_id": "MD-4.4-DipolarRotationalPrinted",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170",
  "pdf_page": "192",
  "statement_latex": "Then $K_{\\rm rot}=\\sum_{i=1}^N\\operatorname{Tr}[\\dot\\Theta_iR\\dot\\Theta_i^T]$, with $R$ defined in terms of $T=\\operatorname{diag}(I_1,I_2,I_3)$ by (4.40).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p170 Ex4.1 trace动能印刷少1/2；R与T关系亦引用疑误式。"
    }
  ],
  "lean_decl": "MD.Ch04.dipolarRotationalPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def dipolarRotationalPrinted {N : ℕ} (R : MolecularDynamics.Chapter04Review.Mat3) (dΘ : Fin N → MolecularDynamics.Chapter04Review.Mat3) : ℝ :=
  ∑ i, (dΘ i*R*(dΘ i)ᵀ).trace
```

