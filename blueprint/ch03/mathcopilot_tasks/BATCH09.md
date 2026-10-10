# BATCH09 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.3.2-StrangInverse
```json
{
  "source_id": "MD-3.3.2-StrangInverse",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.2",
  "printed_page": "108",
  "pdf_page": "130",
  "statement_latex": "Setting $s=-t$, the left hand side of (3.4) collapses to the identity.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "(3.4)完整形式乘积见同页DifferentLogsCommute；本条单独反步恒等式不假设不同步长log交换。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.strangInverse",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem strangInverse :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), formalStrang A B * formalStrang (-A) (-B)=1
```

### MD-3.3.2-StrangCubic
```json
{
  "source_id": "MD-3.3.2-StrangCubic",
  "kind": "unnumbered_claim",
  "label": "(3.6)–(3.7)",
  "section": "3.3.2",
  "printed_page": "108",
  "pdf_page": "130",
  "statement_latex": "\\[\\exp(\\tfrac t2X)\\exp(tY)\\exp(\\tfrac t2X)=\\exp(t(X+Y)+t^3\\widehat Z_{[3]}+\\cdots),\\tag{3.6}\\]\nwhere\n\\[\\widehat Z_{[3]}=\\frac1{12}[Y,[Y,X]]-\\frac1{24}[X,[X,Y]].\\tag{3.7}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$X,Y$为非交换形式生成元；[A,B]=AB−BA；签名直接为真实formalLog三次系数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.strangCubic",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem strangCubic :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 3 (formalLog (formalStrang A B))=
      (1/12:ℝ) • commutator B (commutator B A)-(1/24:ℝ) • commutator A (commutator A B)
```

