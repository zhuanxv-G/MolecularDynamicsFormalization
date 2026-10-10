# BATCH28 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.5.1-GaussTwo
```json
{
  "source_id": "MD-2.5.1-GaussTwo",
  "kind": "definition",
  "label": null,
  "section": "2.5.1",
  "printed_page": "90",
  "pdf_page": "112",
  "statement_latex": "The 4th order method ($s=2$) has coefficients\n\\[b_1=b_2=\\frac12,\\qquad A=(a_{ij})=\\begin{bmatrix}\\frac14&\\frac14-\\frac{\\sqrt3}6\\\\\\frac14+\\frac{\\sqrt3}6&\\frac14\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本定义完整A及b；四阶子句来自GaussFamily(s=2)的大型配点阶理论，不能只凭系数称已证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.gaussTwoData",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def gaussTwoData : Matrix (Fin 2) (Fin 2) ℝ × (Fin 2 → ℝ) :=
  (gaussTwoCoefficients, fun _ => 1/2)
```

### MD-2.5.1-GaussTwoOrder
```json
{
  "source_id": "MD-2.5.1-GaussTwoOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.1",
  "printed_page": "90",
  "pdf_page": "112",
  "statement_latex": "The 4th order method ($s=2$) has coefficients",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页GaussTwoData保存全部A、b；此条保存确切2阶段方法全局4阶结论而非仅系数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.gaussTwoOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]C⁶实际向量场/解轨迹，实际C⁶步族且满足阶段关系；实际求解资格，不把4阶误差作为前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gaussTwoOrder : ∀ n (f : Q n → Q n) (G : ℝ → Q n → Q n)
    (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → ContDiff ℝ 6 (Function.uncurry G) →
    (∀ h z, ∃ stages : Fin 2 → Q n,
      rungeKuttaRelation f gaussTwoCoefficients (fun _ => 1/2) h z (G h z) stages) →
    globalOrder G γ τ 4
```

