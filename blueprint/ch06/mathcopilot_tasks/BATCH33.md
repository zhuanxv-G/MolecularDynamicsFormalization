# BATCH33 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4-CanonicalMixingMeaning
```json
{
  "source_id": "MD-6.4-CanonicalMixingMeaning",
  "kind": "definition",
  "label": null,
  "section": "6.4",
  "printed_page": "244",
  "pdf_page": "265",
  "statement_latex": "At any time $t$ we take a snapshot $M_t$ of the resulting set of random variables. Eventually we hope that the points will be distributed in the entire phase space in accordance with the target measure (usually the Gibbs distribution $e^{-\\beta H}$).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.canonicalMixingMeaning",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实概率目标和任意点初始law、全部有界连续检验函数弱混合定义；没有宣称所有SDE自动满足。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def canonicalMixingMeaning {D : Type*} [TopologicalSpace D] [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ x : D, ∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂K t.toNNReal x) atTop (𝓝 (∫ z, f z ∂μ))
```

