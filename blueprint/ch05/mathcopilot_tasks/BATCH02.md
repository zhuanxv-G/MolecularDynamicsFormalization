# BATCH02 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.1-SolutionOperator
```json
{
  "source_id": "MD-5.1-SolutionOperator",
  "kind": "definition",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "$\\widetilde g(z,t)=G_t\\widetilde g(z,0),\\qquad\\hbox{where }G_t=e^{t\\mathcal L_f}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实pullback解算子；exp是原书给定的算子记号，不声称未建设的无界指数级数收敛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.solutionOperator",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def solutionOperator {X : Type*} (Φ : ℝ → X → X) (t : ℝ) (g : X → ℝ) := MolecularDynamics.Chapter05Review.pullback Φ g t
```

### MD-5.1-CoordinateLie
```json
{
  "source_id": "MD-5.1-CoordinateLie",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "In this notation, the symbol $\\partial_i$ refers to the $i$th coordinate function of $z$ ($\\partial_i(z)=z_i$). Calculating directly we have $\\mathcal L_fz_i=f_i$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留实际EuclideanSpace的第i坐标投影；∂i是原书的坐标函数，不是对其它函数的偏导。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.coordinateLie",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem coordinateLie : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n),
  MolecularDynamics.Chapter05Review.lie f (fun x => x i) z=f z i
```

### MD-5.1-LiePullbackCommutes
```json
{
  "source_id": "MD-5.1-LiePullbackCommutes",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "$(\\mathcal L_f\\widetilde g)(z)=f(z)\\cdot\\nabla_z[g(\\mathcal F_t(z))]\n=f(z)\\cdot\\mathcal F_t'(z)^T\\nabla g(\\mathcal F_t(z))\n=\\mathcal F_t'(z)f(z)\\cdot\\nabla g(\\mathcal F_t(z))\n=f(\\mathcal F_t(z))\\cdot\\nabla g(\\mathcal F_t(z))\n=(\\mathcal L_fg)(\\mathcal F_t(z))$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.liePullbackCommutes",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem liePullbackCommutes : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=MolecularDynamics.Chapter05Review.lie f g (Φ t z)
```

