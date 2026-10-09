# BATCH03 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.1.2-SecondDerivative
```json
{
  "source_id": "MD-2.1.2-SecondDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.1.2",
  "printed_page": "59",
  "pdf_page": "81",
  "statement_latex": "and the second derivative is obtained by differentiating the differential equation itself:\n\\[\\ddot{\\boldsymbol z}(t)=\\frac{\\mathrm d}{\\mathrm dt}\\dot{\\boldsymbol z}(t)=\\frac{\\mathrm d}{\\mathrm dt}f(\\boldsymbol z(t))=f'(\\boldsymbol z(t))\\dot{\\boldsymbol z}(t)=f'(\\boldsymbol z(t))f(\\boldsymbol z(t)),\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$f\\in C^1$，$\\dot z=f(z)$；$f'$为实际Fréchet导数/Jacobian。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.odeSecondDerivative",
  "reusable_proofs": [],
  "extra_assumptions": [
    "解γ取C²；原文连续求两次时间导数的正则性显式化。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-014"
  ]
}
```
```lean
theorem odeSecondDerivative :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n), ContDiff ℝ 1 f → ContDiff ℝ 2 γ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (deriv γ) ((fderiv ℝ f (γ t)) (f (γ t))) t
```

### MD-2.1.2-Taylor2
```json
{
  "source_id": "MD-2.1.2-Taylor2",
  "kind": "definition",
  "label": "Example 2.1 (map)",
  "section": "2.1.2",
  "printed_page": "59",
  "pdf_page": "81",
  "statement_latex": "so one may write the 2nd order Taylor series method as\n\\[\\boldsymbol z_{n+1}=\\boldsymbol z_n+hf(\\boldsymbol z_n)+\\frac{h^2}{2}f'(\\boldsymbol z_n)f(\\boldsymbol z_n).\\]\nThis method generates the flow map approximation\n\\[\\mathcal G_h(\\boldsymbol z)=\\boldsymbol z+hf(\\boldsymbol z)+\\frac{h^2}{2}f'(\\boldsymbol z)f(\\boldsymbol z).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Note that by the notation $f'(\\boldsymbol z)$ where $\\boldsymbol z\\in\\mathbb R^m$ and $f:\\mathbb R^m\\to\\mathbb R^m$, is meant the $m\\times m$ Jacobian matrix whose $ij$-component is $(f'(\\boldsymbol z))_{ij}=\\partial f_i/\\partial z_j$. An alternative notation for $f'$ is $\\partial f/\\partial\\boldsymbol z$."
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.taylorSecond",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-015",
    "CH02-017"
  ]
}
```
```lean
def taylorSecond {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  z + h • f z + (h^2 / 2) • (fderiv ℝ f z) (f z)
```

### MD-2.1.2-Taylor2Order
```json
{
  "source_id": "MD-2.1.2-Taylor2Order",
  "kind": "unnumbered_claim",
  "label": "Example 2.1 (order)",
  "section": "2.1.2",
  "printed_page": "59",
  "pdf_page": "81",
  "statement_latex": "which is referred to as the 2nd order Taylor series method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页方法公式及前段全局有限时间窗高阶误差定义；“2nd order”含阶陈述。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.taylor2Order",
  "reusable_proofs": [],
  "extra_assumptions": [
    "compactTrajectory要求f全域C⁶及实际解在固定紧时间窗连续；强于二阶所需，标[EXTRA]，仍需证明局部误差及稳定留域。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-016"
  ]
}
```
```lean
theorem taylor2Order :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → globalOrder (taylor2 f) γ τ 2
```

