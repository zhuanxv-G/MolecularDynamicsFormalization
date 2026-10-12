# BATCH26 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4.1-ExactPlanarRotation
```json
{
  "source_id": "MD-4.4.1-ExactPlanarRotation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.exactPlanarRotation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]第二/第三子场按完整π₂/π₃解释，与PrincipalAxisField一致；显式负角主动旋转给出(4.41)的π×ω符号，不将原表正角错误候选当作该精确子流。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem exactPlanarRotation : ∀ (I π : MolecularDynamics.Chapter04Review.V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => MolecularDynamics.Chapter04Review.axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ (MolecularDynamics.Chapter04Review.cross3 (γ t) (Pi.single i (γ t i/I i))) t
```

