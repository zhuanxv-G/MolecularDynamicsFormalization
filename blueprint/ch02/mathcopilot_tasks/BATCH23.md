# BATCH23 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.4.2-CompositionSymplectic
```json
{
  "source_id": "MD-2.4.2-CompositionSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.2",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "Starting from two different methods $\\mathcal G_{1,h}$ and $\\mathcal G_{2,h}$, as long as they are both symplectic methods, we can use the composition of the maps\n\\[\\mathcal G_h=\\mathcal G_{1,h/2}\\circ\\mathcal G_{2,h/2}\\]\nas an alternative symplectic integrator.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.compositionSymplectic",
  "reusable_proofs": [
    "MolecularDynamics.textbookComposeMaps_isSymplectic"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem compositionSymplectic {Nc : ℕ}
    (G₁ G₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hG₁ : ∀ h, IsTextbookSymplecticMap (G₁ h))
    (hG₂ : ∀ h, IsTextbookSymplecticMap (G₂ h)) (h : ℝ) :
    IsTextbookSymplecticMap (textbookComposeMaps G₁ G₂ h)
```

### MD-2.4.2-CompositionOrder
```json
{
  "source_id": "MD-2.4.2-CompositionOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.2",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "The order of accuracy of the resulting method is typically the minimum of that of the two starting integrators, but as the Verlet method shows, it can be higher in certain instances.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.compositionOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]两个方法逼近同一实际流；第一个方法1+L|h|稳定；陈述保留至少min阶，允许更高，不把“typically”冒充确切阶相等。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem compositionOrder :
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s)
```

