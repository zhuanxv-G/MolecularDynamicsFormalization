# BATCH01 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.1.1-Microcanonical
```json
{
  "source_id": "MD-6.1.1-Microcanonical",
  "kind": "definition",
  "label": null,
  "section": "6.1.1",
  "printed_page": "214",
  "pdf_page": "235",
  "statement_latex": "The density function may then be represented by a Dirac delta function as follows:\n\\[\\rho_{\\rm mc}=Z^{-1}\\delta[H-E],\\qquad Z=\\int_D\\delta[H-E]d\\omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "δ[H−E]是正则能量面上的1/‖∇H‖加权Hausdorff测度，不是环境Lebesgue密度；沿用第5章真实microMeasure定义。",
    "固定N,V,E及正则能量、正有限partition才有概率解释；不重新证明coarea识别。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.microcanonical",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def microcanonical {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (energy : ℝ) :=
  MolecularDynamics.Chapter05Review.microMeasure H energy
```

