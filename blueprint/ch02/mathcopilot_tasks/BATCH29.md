# BATCH29 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.5.2-PartitionedVerlet
```json
{
  "source_id": "MD-2.5.2-PartitionedVerlet",
  "kind": "definition",
  "label": null,
  "section": "2.5.2",
  "printed_page": "90",
  "pdf_page": "112",
  "statement_latex": "As an illustration, consider the method:\n\\[\\hat{\\boldsymbol P}=\\boldsymbol p-\\frac h2\\nabla_qH(\\boldsymbol q,\\hat{\\boldsymbol P}),\\tag{2.26}\\]\n\\[\\boldsymbol Q=\\boldsymbol q+\\frac h2(\\nabla_pH(\\boldsymbol q,\\hat{\\boldsymbol P})+\\nabla_pH(\\boldsymbol Q,\\hat{\\boldsymbol P})),\\tag{2.27}\\]\n\\[\\boldsymbol P=\\hat{\\boldsymbol P}-\\frac h2\\nabla_qH(\\boldsymbol Q,\\hat{\\boldsymbol P}).\\tag{2.28}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际H(q,p)两个偏导与中间动量；不假设隐式关系全球可解。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_partitionedVerletRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_partitionedVerletRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) (p : Q n) : Prop :=
  p = z.2 - (h/2) • partialQ H z.1 p ∧
  w.1 = z.1 + (h/2) • (partialP H z.1 p + partialP H w.1 p) ∧
  w.2 = p - (h/2) • partialQ H w.1 p
```

### MD-2.5.2-PartitionedReduction
```json
{
  "source_id": "MD-2.5.2-PartitionedReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.2",
  "printed_page": "91",
  "pdf_page": "113",
  "statement_latex": "When $H=\\boldsymbol p^TM^{-1}\\boldsymbol p/2+U(\\boldsymbol q)$ this is just the leapfrog/Verlet method, but it can be used also for more general systems.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.partitionedReduction",
  "reusable_proofs": [],
  "extra_assumptions": [
    "固定正对角质量、U实际可微；中间动量存在关系与Verlet映射等价。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem partitionedReduction :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z w,
    positiveMass m → Differentiable ℝ U →
    ((∃ p, partitionedVerletRelation (fun z : Z n => (∑ i, z.2 i^2/m i)/2+U z.1) h z w p) ↔
      w = verlet m (fun q => -grad U q) h z)
```

### MD-2.5.2-GeneralEuler
```json
{
  "source_id": "MD-2.5.2-GeneralEuler",
  "kind": "definition",
  "label": null,
  "section": "2.5.2",
  "printed_page": "91",
  "pdf_page": "113",
  "statement_latex": "where $\\mathcal G_h$ is defined by\n\\[\\boldsymbol P=\\boldsymbol p-h\\nabla_qH(\\boldsymbol q,\\boldsymbol P),\\tag{2.29}\\]\n\\[\\boldsymbol Q=\\boldsymbol q+h\\nabla_pH(\\boldsymbol q,\\boldsymbol P),\\tag{2.30}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际隐式辛Euler关系，真实求解及可微资格在辛性条目。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_generalSymplecticEulerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_generalSymplecticEulerRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 - h • partialQ H z.1 w.2 ∧ w.1 = z.1 + h • partialP H z.1 w.2
```

### MD-2.5.2-GeneralSymplectic
```json
{
  "source_id": "MD-2.5.2-GeneralSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.2",
  "printed_page": "91",
  "pdf_page": "113",
  "statement_latex": "To see that it is symplectic, we first note that this is a symmetric composition of the form\n\\[\\mathcal K_h=\\mathcal G_{h/2}^*\\circ\\mathcal G_{h/2},\\]\nso it is enough to show that this basic method is symplectic.",
  "proof_latex": "Taking differentials of (2.30) defining $\\mathcal G_h$ and then wedge products and summing, we have\n\\[\\sum_i dQ_i\\wedge dP_i=\\sum_i dq_i\\wedge dP_i+h\\sum_i\\sum_j H_{p_iq_j}dq_j\\wedge dP_i+h\\sum_i\\sum_j H_{p_ip_j}dP_j\\wedge dP_i.\\]\nThe last term on the right vanishes by equality of mixed partials and the antisymmetry of the wedge product. On the other hand, using (2.29), we obtain, by similar means,\n\\[\\sum_i dq_i\\wedge dP_i=\\sum_i dq_i\\wedge dp_i-h\\sum_i\\sum_j H_{q_ip_j}dq_i\\wedge dP_j.\\]\nRelabelling the indices in the sum and using our previous work results in\n\\[\\sum_i dQ_i\\wedge dP_i=\\sum_i dq_i\\wedge dp_i,\\]\nimplying that the method is symplectic.",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.generalSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "H C²，真实C¹完整求解映射，逐点满足实际隐式关系。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem generalSymplectic :
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n) h,
    ContDiff ℝ 2 H → ContDiff ℝ 1 G →
    (∀ z, generalSymplecticEulerRelation H h (unpack z) (unpack (G z))) → IsTextbookSymplecticMap G
```

### MD-2.5.2-GeneralVerletSymplectic
```json
{
  "source_id": "MD-2.5.2-GeneralVerletSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.2",
  "printed_page": "91",
  "pdf_page": "113",
  "statement_latex": "To see that it is symplectic, we first note that this is a symmetric composition",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整原文主语是(2.26)–(2.28)；GeneralSymplectic条目保存全部原书证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.generalVerletSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "H C²，实际C¹中间动量和完整求解映射，满足三步隐式关系。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem generalVerletSymplectic :
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (p : SymplecticCoordinates n → Q n) h, ContDiff ℝ 2 H → ContDiff ℝ 1 G → ContDiff ℝ 1 p →
    (∀ z, partitionedVerletRelation H h (unpack z) (unpack (G z)) (p z)) → IsTextbookSymplecticMap G
```

