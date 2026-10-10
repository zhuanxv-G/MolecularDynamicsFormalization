# BATCH19 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.3.6-SymplecticIntegrator
```json
{
  "source_id": "MD-2.3.6-SymplecticIntegrator",
  "kind": "definition",
  "label": null,
  "section": "2.3.6",
  "printed_page": "80",
  "pdf_page": "102",
  "statement_latex": "A symplectic integrator is an approximation of the flow map that conserves the symplectic 2-form.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "G为给定单步方法；精度资格在前节另行定义；每个可用h步映射保辛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_symplecticIntegrator",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_symplecticIntegrator {n : ℕ} (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∀ h, IsTextbookSymplecticMap (G h)
```

### MD-2.3.6-SymplecticEuler
```json
{
  "source_id": "MD-2.3.6-SymplecticEuler",
  "kind": "definition",
  "label": null,
  "section": "2.3.6",
  "printed_page": "80",
  "pdf_page": "102",
  "statement_latex": "The following scheme is a slight modification of the Euler method.\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol P,\\tag{2.18}\\]\n\\[\\boldsymbol P=\\boldsymbol p+hF(\\boldsymbol q).\\tag{2.19}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "固定对角质量，F=-∇U；先P后Q；原文explicit不等于声称隐式法解存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_symplecticEuler",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def bp_symplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h
```

### MD-2.3.6-KickDifferential
```json
{
  "source_id": "MD-2.3.6-KickDifferential",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.6",
  "printed_page": "81",
  "pdf_page": "103",
  "statement_latex": "then\n\\[dQ_i=dq_i+hm_i^{-1}dP_i,\\tag{2.20}\\]\n\\[dP_i=dp_i-h\\sum_{j=1}^{N_c}\\frac{\\partial^2U}{\\partial q_j\\partial q_i}dq_j.\\tag{2.21}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "P来自kick，Q来自position drift；dP/dQ是完整步映射实际Fréchet导数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.kickDifferential",
  "reusable_proofs": [],
  "extra_assumptions": [
    "U C²，实际Hessian。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem kickDifferential : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    ContDiff ℝ 2 U → ∀ ξ : SymplecticCoordinates n, ∀ i : Fin n,
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inl i) =
        ξ (Sum.inl i)+h*(m i)⁻¹*((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) ∧
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) =
        ξ (Sum.inr i)-h*((fderiv ℝ (grad U) (z ∘ Sum.inl)) (ξ ∘ Sum.inl)) i
```

### MD-2.3.6-WedgeSelf
```json
{
  "source_id": "MD-2.3.6-WedgeSelf",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.6",
  "printed_page": "81",
  "pdf_page": "103",
  "statement_latex": "but $du\\wedge du\\equiv0$ for any $u$,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.wedgeSelf",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.wedgeSelf_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem wedgeSelf :
  ∀ n (α : SymplecticCoordinates n →ₗ[ℝ] ℝ) u v, textbookWedgeOneForms α α u v = 0
```

### MD-2.3.6-SymplecticEulerPreserves
```json
{
  "source_id": "MD-2.3.6-SymplecticEulerPreserves",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.6",
  "printed_page": "81",
  "pdf_page": "103",
  "statement_latex": "This implies that\n\\[\\sum_{i=1}^{N_c}dQ_i\\wedge dP_i=\\sum_{i=1}^{N_c}dq_i\\wedge dp_i,\\]\nwhich means that the method is symplectic.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.symplecticEulerPreserves",
  "reusable_proofs": [
    "MolecularDynamics.textbookSymplecticEuler_isSymplectic"
  ],
  "extra_assumptions": [
    "U C²，固定对角质量；真实完整步映射。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerPreserves {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticMap (textbookSymplecticEuler m U h)
```

