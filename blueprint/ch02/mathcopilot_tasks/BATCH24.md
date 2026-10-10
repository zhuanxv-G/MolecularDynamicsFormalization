# BATCH24 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.4.3-HarmonicSplit
```json
{
  "source_id": "MD-2.4.3-HarmonicSplit",
  "kind": "definition",
  "label": null,
  "section": "2.4.3",
  "printed_page": "85–86",
  "pdf_page": "107–108",
  "statement_latex": "Suppose that we have a Hamiltonian of the form $H=H_0+H_1$ where $H_0=\\boldsymbol p^TM^{-1}\\boldsymbol p/2+\\boldsymbol q^TA\\boldsymbol q/2$ defines a system of harmonic oscillators, whereas $H_1(\\boldsymbol q,\\boldsymbol p)=\\tilde U(\\boldsymbol q)$ is an anharmonic perturbation. In the simplest case, we can consider $H_0=(1/2)p^2+(\\Omega^2/2)q^2$, then a scheme of this type would be\n\\[\\begin{bmatrix}Q\\\\\\hat p\\end{bmatrix}=\\begin{bmatrix}\\cos(h\\Omega)&\\sin(h\\Omega)/\\Omega\\\\-\\Omega\\sin(h\\Omega)&\\cos(h\\Omega)\\end{bmatrix}\\begin{bmatrix}q\\\\p\\end{bmatrix},\\qquad P=\\hat p-h\\tilde U'(Q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Lean定义是原文明确标量简例；一般矩阵分裂作为同条背景记号保留。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_harmonicAnharmonic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_harmonicAnharmonic (Ω : ℝ) (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := Real.cos (h*Ω)*z.1 + Real.sin (h*Ω)/Ω*z.2
  (q, -Ω*Real.sin (h*Ω)*z.1 + Real.cos (h*Ω)*z.2 - h*deriv U q)
```

