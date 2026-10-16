# BATCH24 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3.5-ScalarGenerator
```json
{
  "source_id": "MD-6.3.5-ScalarGenerator",
  "kind": "definition",
  "label": "(6.38)",
  "section": "6.3.5",
  "printed_page": "240",
  "pdf_page": "261",
  "statement_latex": "where $\\mathcal L$ is a linear operator, called the generator of the stochastic process, defined by\n\\[\\mathcal L=a(x)\\frac d{dx}+\\tfrac12 b^2(x)\\frac{d^2}{dx^2}.\\tag{6.38}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实一、二阶导数及1/2系数，C²资格在应用定理给出。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.scalarGenerator",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def scalarGenerator (a b f : ℝ → ℝ) (x : ℝ) : ℝ := a x*deriv f x + b x^2/2*deriv (deriv f) x
```

### MD-6.3.5-GeneratorExpectation
```json
{
  "source_id": "MD-6.3.5-GeneratorExpectation",
  "kind": "unnumbered_claim",
  "label": "(6.37)",
  "section": "6.3.5",
  "printed_page": "240",
  "pdf_page": "261",
  "statement_latex": "Then, taking the expectation of the Itô-Doeblin formula (6.17) we find\n\\[\\mathbb E\\{d\\phi(X)\\}=\\mathbb E\\{\\phi'(X)a(X)\\}dt+\\tfrac12\\mathbb E\\{\\phi''(X)b(X)^2\\}dt\n=\\mathbb E\\{(\\mathcal L\\phi)(X)\\}dt.\\tag{6.37}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.generatorExpectation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实严格SDE、C²φ、适应平方可积资格、Lφ实际可积且时间期望连续；完整期望时间导数，不只定义L。",
    "[EXTRA]自然Wiener历史适应、联合可测X、C¹a/b及Lφ在每个有限时间×样本上的绝对可积资格，保证实际Fubini；有符号期望连续不自动蕴含此资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem generatorExpectation :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (a b φ : ℝ → ℝ) (x0 : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ 1 a → ContDiff ℝ 1 b → ContDiff ℝ 2 φ → MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample)) →
  (∀ t : ℝ, 0 ≤ t → Integrable (fun sample ↦ MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample)) P) →
  ContinuousOn (fun t ↦ ∫ sample, MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample) ∂P) (Ici 0) →
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) →
  Measurable (Function.uncurry X) →
  (∀ T : ℝ, 0 ≤ T → Integrable
    (fun w : ℝ × Ω ↦ |MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X w.1 w.2)|)
    ((volume.restrict (Icc 0 T)).prod P)) →
  ∀ t : ℝ, 0 < t → HasDerivAt (fun s ↦ ∫ sample, φ (X s sample) ∂P)
    (∫ sample, MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample) ∂P) t
```

