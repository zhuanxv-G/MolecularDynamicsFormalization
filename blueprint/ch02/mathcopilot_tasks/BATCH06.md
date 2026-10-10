# BATCH06 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.2.1-EulerLagrange
```json
{
  "source_id": "MD-2.2.1-EulerLagrange",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.1",
  "printed_page": "62",
  "pdf_page": "84",
  "statement_latex": "Since the variation $\\boldsymbol\\eta$ is meant to be arbitrary, it requires\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\frac{\\partial L}{\\partial\\dot{\\boldsymbol q}}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))=\\frac{\\partial L}{\\partial\\boldsymbol q}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t)),\\]\nwhich is precisely the Lagrangian formulation of the equations of motion.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonPrinciple",
  "reusable_proofs": [],
  "extra_assumptions": [
    "α<β，L和q C²；变分按原文C∞且零端点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-027"
  ]
}
```
```lean
theorem hamiltonPrinciple :
  ∀ n (L : Q n → Q n → ℝ) (q : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q →
    (stationarySmoothAction L a b q ↔ ∀ t ∈ Ioo a b,
      HasDerivAt (fun s => fderiv ℝ (L (q s)) (deriv q s))
        (fderiv ℝ (fun x => L x (deriv q t)) (q t)) t)
```

### MD-2.2.1-VariationalDerivativePrinted
```json
{
  "source_id": "MD-2.2.1-VariationalDerivativePrinted",
  "kind": "definition",
  "label": null,
  "section": "2.2.1",
  "printed_page": "62",
  "pdf_page": "84",
  "statement_latex": "Define the variational derivative of a functional $\\mathcal F$, $\\delta\\mathcal F/\\delta\\boldsymbol q$ so that\n\\[\\mathcal F(\\boldsymbol q+\\epsilon\\boldsymbol\\eta)=\\epsilon\\frac{\\delta\\mathcal F}{\\delta\\boldsymbol q}\\boldsymbol\\eta+O(\\epsilon^2),\\]\nfor all suitable (say, $C^\\infty$) functions $\\boldsymbol\\eta$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "左式漏F(q)，原页实际如此。字面定义对于非零常值F无解，不能静默替成HasFDerivAt。"
    }
  ],
  "lean_decl": "MD.Ch02.printedVariationalDerivative",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-028"
  ]
}
```
```lean
def printedVariationalDerivative {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (q : E) (A : E →L[ℝ] ℝ) : Prop :=
  ∀ η : E, Asymptotics.IsBigO (𝓝 0)
    (fun ε : ℝ => F (q + ε • η) - ε * A η) (fun ε : ℝ => ε^2)
```

### MD-2.2.1-StationaryNotMin
```json
{
  "source_id": "MD-2.2.1-StationaryNotMin",
  "kind": "unnumbered_claim",
  "label": "Footnote 4",
  "section": "2.2.1",
  "printed_page": "62",
  "pdf_page": "84",
  "statement_latex": "Any curve which satisfies this equation will represent a “stationary point” (actually, “stationary curve” would be more accurate) of the classical action. Such curves could include smooth local action minimizers, local action maximizers, or “saddle points” of the actional functional in a generalized sense. Deciding whether a given stationary curve is an actual minimizer of the action would require analysis of the second variation (the coefficient of $\\epsilon^2$ in the expansion above), which introduces additional complexity.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.stationaryNotMinimum",
  "reusable_proofs": [],
  "extra_assumptions": [
    "用存在驻值但非局部极小的实际L与曲线反例表达could，不声称所有驻值不是极小。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-029"
  ]
}
```
```lean
theorem stationaryNotMinimum :
  ∃ (L : Q 1 → Q 1 → ℝ) (q : ℝ → Q 1),
    ContDiff ℝ 2 (Function.uncurry L) ∧ ContDiff ℝ 2 q ∧ stationaryAction L 0 1 q ∧
    ∀ δ > 0, ∃ η : ℝ → Q 1, ContDiff ℝ 2 η ∧ η 0 = 0 ∧ η 1 = 0 ∧
      (∀ t ∈ Icc (0 : ℝ) 1, ‖η t‖ < δ) ∧ action L 0 1 (fun t => q t + η t) < action L 0 1 q
```

