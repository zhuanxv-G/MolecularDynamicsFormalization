# BATCH05 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.2.1-ClosedSupport
```json
{
  "source_id": "MD-5.2.1-ClosedSupport",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "the support of a function $f$ is the closure of the set of arguments for which the function is nonzero and is denoted $\\operatorname{supp}f$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "tsupport=closure(Function.support f)；和非零点集合明确区分。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.closedSupport",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def closedSupport {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) : Set (MolecularDynamics.Chapter05Review.E n) := tsupport f
```

### MD-5.2.1-GaussianL2
```json
{
  "source_id": "MD-5.2.1-GaussianL2",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "$L^2(\\mathbb R^m)$ also includes many other types of functions important in molecular modelling, for example the multivariate Gaussian $\\exp(-\\sum_{i=1}^m\\alpha_i x_i^2)$, where $\\alpha_i>0,i=1,2,\\ldots,m$ are coefficients; such a function goes rapidly to zero as any $x_i\\to\\infty$, so the improper integral converges.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真正任意有限维加权Gaussian，未改为径向单一系数或有界域。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.gaussianL2",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gaussianL2 : ∀ n (a : Fin n → ℝ), (∀ i,0 < a i) →
  MemLp (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) 2 volume
```

### MD-5.2.1-FiniteJumpL2
```json
{
  "source_id": "MD-5.2.1-FiniteJumpL2",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "$L^2(\\mathbb R^m)$ also includes the compactly supported functions with finite “jump discontinuities” at a finite number of locations.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.finiteJumpL2",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem finiteJumpL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ) (S : Set (MolecularDynamics.Chapter05Review.E n)),
  S.Finite → HasCompactSupport g → ContinuousOn g Sᶜ →
  (∀ z ∈ S,∃ C > 0,∃ U ∈ 𝓝 z,∀ x ∈ U,|g x| ≤ C) →
    MemLp g 2 volume
```

### MD-5.2.1-NormalizedAverageFormula
```json
{
  "source_id": "MD-5.2.1-NormalizedAverageFormula",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "$\\operatorname{Av}_\\rho(g)\\stackrel{\\rm def}{=}\\frac{1}{\\int_D\\rho(z)\\,d\\omega}\\langle g,\\rho\\rangle=\\int_Dg\\widehat\\rho\\,d\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "积分比值的实际线性恒等式；概率解释另须正分母及原密度条件，不将代数式误当所有输入都有概率意义。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.normalizedAverageFormula",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem normalizedAverageFormula : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityAverageOn D ρ g=(∫ z in D,g z*(ρ z/(∫ x in D,ρ x)))
```

