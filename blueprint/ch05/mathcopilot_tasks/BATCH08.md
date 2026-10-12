# BATCH08 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.2.2-RapidAdjoint
```json
{
  "source_id": "MD-5.2.2-RapidAdjoint",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185–186",
  "pdf_page": "206–207",
  "statement_latex": "Let $u,v$ be two scalar valued functions in $\\mathbb R^m$ which tend to zero sufficiently rapidly at infinity. By our assumptions that $u$ and $v$ are rapidly decaying we know that $B\\to0$, as $\\ell\\to\\infty$. Taking the limit, we are thus left with the equation\n\\[\\langle u,\\mathcal L_fv\\rangle=-\\sum_i\\int_{\\mathbb R^m}v\\frac{\\partial}{\\partial z_i}(uf_i)\\,d\\omega=\\langle M_fu,v\\rangle.\\]\nWe refer to $M_f$ as the adjoint operator of $\\mathcal L_f$ and we write $M_f=\\mathcal L_f^*$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.rapidAdjoint",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rapidAdjoint : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*MolecularDynamics.Chapter05Review.lie f v z) volume →
  Integrable (fun z => MolecularDynamics.Chapter05Review.liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z)
```

### MD-5.2.2-CompactAdjoint
```json
{
  "source_id": "MD-5.2.2-CompactAdjoint",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185–186",
  "pdf_page": "206–207",
  "statement_latex": "$\\langle u,\\mathcal L_fv\\rangle=\\langle M_fu,v\\rangle$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.liouvillianAdjoint",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]紧支持C¹版本，作为快速衰减完整条目的特殊情形另列；是微分表达式的积分配对，不是闭Hilbert算子伴随的域识别。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem liouvillianAdjoint :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v → HasCompactSupport u → HasCompactSupport v →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z)
```

### MD-5.2.2-MeasurePropagator
```json
{
  "source_id": "MD-5.2.2-MeasurePropagator",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "186",
  "pdf_page": "207",
  "statement_latex": "The density $\\rho$ evolves as the solution of the partial differential equation $\\partial\\rho/\\partial t=\\mathcal L_f^*\\rho$, where we interpret $\\rho$ as a function of both $z$ and $t$ and view $\\mathcal L_f^*$ as only operating on the spatial components. This means, formally, $\\rho(z;t)=e^{t\\mathcal L_f^*}\\rho(z;0)$. We can think of $\\exp(t\\mathcal L_f^*)$ as defining the propagator of measure.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Measure.map输运；形式exp仅记号，不宣称已构造无界闭算子指数或一般密度PDE解。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.measurePropagator",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def measurePropagator {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ
```

