# BATCH22 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.6.3-ReversibleVolumeFailure
```json
{
  "source_id": "MD-3.6.3-ReversibleVolumeFailure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.3",
  "printed_page": "132",
  "pdf_page": "154",
  "statement_latex": "Of particular importance for molecular dynamics are the following properties: a symplectic map will preserve volume, whereas a time-reversible map need not do so, and a symplectic integrator will approximately conserve energy due to the existence of the perturbed Hamiltonian, whereas a time-reversible integrator may give rise to a drift in energy [166].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条保留真实可逆光滑非保体积反例；辛体积与BEA能量性质已在前章及§3.4保留；可逆方法能量漂移按may定性。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.reversibleVolumeFailure",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem reversibleVolumeFailure :
  ∃ (n : ℕ) (R : Q n →L[ℝ] Q n) (G : Q n ≃ Q n), linearInvolution R ∧
    ContDiff ℝ 1 G ∧ ContDiff ℝ 1 G.symm ∧ (∀ z, R (G (R (G z)))=z) ∧
    ∃ z, |(textbookCoordinateJacobian G z).det| ≠ 1
```

