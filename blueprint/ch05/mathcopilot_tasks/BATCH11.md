# BATCH11 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.3.1-DiracApproximation
```json
{
  "source_id": "MD-5.3.1-DiracApproximation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "This concept of the delta function (that appears in the integral) may be motivated by introducing a sequence of continuous functions $d_\\varepsilon$ having the properties (i) $\\int d_\\varepsilon d\\omega=1$, (ii) $\\operatorname{supp}(d_\\varepsilon)\\to0$, as $\\varepsilon\\to0$. Then the action of the delta function can be seen as the limit of the actions of the functions $d_\\varepsilon$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.diracApproximation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际连续概率密度（原句未写非负，补非负或需统一L¹界）；supp→0解释为闭支持最终在任意零点邻域中，本谓词对非零点支撑的包含和其闭包收缩等价。保留集合supp，不误写函数sup；正ε单侧极限。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem diracApproximation :
  ∀ n (r : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ ε > 0,Continuous (r ε)) →
  (∀ ε > 0,MolecularDynamics.Chapter05Review.probabilityDensity (r ε)) →
  (∀ δ > 0, ∃ η > 0, ∀ ε ∈ Ioo 0 η, Function.support (r ε) ⊆ Metric.ball 0 δ) →
  ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ, Continuous φ →
    Tendsto (fun ε => ∫ z,φ z*r ε z) (𝓝[>] 0) (𝓝 (φ 0))
```

### MD-5.3.1-GaussianDelta
```json
{
  "source_id": "MD-5.3.1-GaussianDelta",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "Alternatively, one may use a sequence of smooth functions $\\{d_\\varepsilon\\}$, such as, in one dimension,\n\\[d_\\varepsilon=\\frac1{\\sqrt{2\\pi\\varepsilon}}\\exp\\left(-\\frac{z^2}{2\\varepsilon}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Gaussian替代族的真实函数，ε>0下有概率解释；其支撑是整个ℝ，未声称它满足上一条紧支撑收缩条件。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.gaussianDelta",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```

### MD-5.3.1-DiracEvaluates
```json
{
  "source_id": "MD-5.3.1-DiracEvaluates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "$\\langle\\delta,\\phi\\rangle=\\int\\delta(z)\\phi(z)d\\omega=\\phi(0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "形式积分以真实Dirac测度实现；不是给δ(z)定义普通Lebesgue函数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.diracEvaluates",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem diracEvaluates : ∀ n (φ : MolecularDynamics.Chapter05Review.schwartzSpace n),
  (∫ z,φ z ∂(MolecularDynamics.Chapter05Review.diracMeasure n))=MolecularDynamics.Chapter05Review.diracAction φ
```

### MD-5.3.1-GaussianDeltaProbability
```json
{
  "source_id": "MD-5.3.1-GaussianDeltaProbability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "Alternatively, one may use a sequence of smooth functions $\\{d_\\varepsilon\\}$, such as, in one dimension,\n\\[d_\\varepsilon=\\frac1{\\sqrt{2\\pi\\varepsilon}}\\exp\\left(-\\frac{z^2}{2\\varepsilon}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.gaussianDeltaProbability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gaussianDeltaProbability : ∀ ε : ℝ,0 < ε →
  (∀ x : ℝ,0 ≤ MolecularDynamics.Chapter05Review.gaussianDelta ε x) ∧ Integrable (MolecularDynamics.Chapter05Review.gaussianDelta ε) volume ∧
  (∫ x,MolecularDynamics.Chapter05Review.gaussianDelta ε x)=1
```

### MD-5.3.1-GaussianDeltaWeak
```json
{
  "source_id": "MD-5.3.1-GaussianDeltaWeak",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "Alternatively, one may use a sequence of smooth functions $\\{d_\\varepsilon\\}$, such as, in one dimension, $d_\\varepsilon=(2\\pi\\varepsilon)^{-1/2}\\exp(-z^2/(2\\varepsilon))$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.gaussianDeltaWeak",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gaussianDeltaWeak : ∀ φ : ℝ → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun ε : ℝ => ∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (𝓝[>] 0) (𝓝 (φ 0))
```

