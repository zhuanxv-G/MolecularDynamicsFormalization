# BATCH22 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.4.1-SymmetricComposition
```json
{
  "source_id": "MD-2.4.1-SymmetricComposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "In fact we can say even more, since $\\mathcal K_h=\\mathcal G_{h/2}^*\\circ\\mathcal G_{h/2}$, we have\n\\[\\mathcal K_h^*=[\\mathcal G_{h/2}^*\\circ\\mathcal G_{h/2}]^*=\\mathcal G_{h/2}^*\\circ\\mathcal G_{h/2}=\\mathcal K_h,\\]\nwhich is to say that this method is self-adjoint or symmetric.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.symmetricComposition",
  "reusable_proofs": [
    "MolecularDynamics.textbookSymmetricComposition_isSelfAdjoint"
  ],
  "extra_assumptions": [
    "实际可逆步Equiv.Perm；完整伴随半步组合。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symmetricComposition {E : Type*}
    (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookSymmetricComposition G) =
      textbookSymmetricComposition G
```

### MD-2.4.1-SymmetricEven
```json
{
  "source_id": "MD-2.4.1-SymmetricEven",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "It is easy to show that symmetric discretization schemes must have even order [14, 29].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.symmetricEven",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symmetricEven :
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ⊤ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ⊤ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r
```

