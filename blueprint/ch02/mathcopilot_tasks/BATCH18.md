# BATCH18 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.3.5-ChainRule
```json
{
  "source_id": "MD-2.3.5-ChainRule",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.5",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "Let $\\Phi_1$ and $\\Phi_2$ be any pair of symplectic maps. Then\n\\[(\\Phi_1\\circ\\Phi_2)'=\\Phi_1'\\Phi_2',\\]\nby the chain rule,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "OMITTED_EVALUATION_POINT",
      "status": "NEEDS_HUMAN",
      "detail": "原文Φ₁′Φ₂′未写外导数的Φ₂(z)取值点；Lean用正确链式法则，需审校确认简写约定。"
    }
  ],
  "lean_decl": "MD.Ch02.chainRule",
  "reusable_proofs": [
    "MolecularDynamics.textbookJacobian_comp"
  ],
  "extra_assumptions": [
    "两个实际映射在相应点可微；外导数在Φ₂(z)取值，原文简写省略底点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem chainRule {Nc : ℕ}
    (Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : Differentiable ℝ Φ) (hΨ : Differentiable ℝ Ψ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (Φ ∘ Ψ) z = textbookJacobian Φ (Ψ z) * textbookJacobian Ψ z
```

### MD-2.3.5-SymplecticComposition
```json
{
  "source_id": "MD-2.3.5-SymplecticComposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.5",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "Thus the composition of any pair of symplectic maps is a symplectic map.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.symplecticComposition",
  "reusable_proofs": [
    "MolecularDynamics.IsTextbookSymplecticMap.comp"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticComposition {Nc : ℕ}
    {Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc}
    (hΦ : IsTextbookSymplecticMap Φ) (hΨ : IsTextbookSymplecticMap Ψ) :
    IsTextbookSymplecticMap (Φ ∘ Ψ)
```

### MD-2.3.5-SymplecticInverse
```json
{
  "source_id": "MD-2.3.5-SymplecticInverse",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.5",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "and the inverse of a symplectic map is symplectic since $\\Phi'^TJ\\Phi'=J$ implies $J=\\Phi'^{-T}J\\Phi'^{-1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.symplecticInverse",
  "reusable_proofs": [
    "MolecularDynamics.IsTextbookSymplecticEquiv.symm"
  ],
  "extra_assumptions": [
    "[EXTRA]e为确实全局双射且e和e⁻¹可微的辛微分同胚；原文前句从det非零推出全球逆无效，另项字面保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticInverse {Nc : ℕ}
    {e : Equiv.Perm (SymplecticCoordinates Nc)} (he : IsTextbookSymplecticEquiv e) :
    IsTextbookSymplecticEquiv e.symm
```

### MD-2.3.5-GlobalGroupPrinted
```json
{
  "source_id": "MD-2.3.5-GlobalGroupPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.5",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "The determinant of a symplectic map is $\\pm1$, hence these maps are always invertible, and the inverse of a symplectic map is symplectic since $\\Phi'^TJ\\Phi'=J$ implies $J=\\Phi'^{-T}J\\Phi'^{-1}$. Thus the symplectic maps form a group under composition.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "Jacobian可逆仅推出局部可逆，不能推出任意辛映射全球双射；正确群是给定全球辛微分同胚。"
    }
  ],
  "lean_decl": "MD.Ch02.globalGroupPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem globalGroupPrinted : ∀ n (Φ : SymplecticCoordinates n → SymplecticCoordinates n),
    IsTextbookSymplecticMap Φ → Function.Bijective Φ ∧
      IsTextbookSymplecticMap (Function.invFun Φ)
```

