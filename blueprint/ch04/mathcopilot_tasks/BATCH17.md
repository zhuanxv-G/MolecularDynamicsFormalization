# BATCH17 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.3.5-SHAKEElimination
```json
{
  "source_id": "MD-4.3.5-SHAKEElimination",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5",
  "printed_page": "161",
  "pdf_page": "183",
  "statement_latex": "It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.shakeElimination",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际相空间SHAKE消元给质量一致M⁻¹(F−Gᵀλ)；原(4.25)缺M⁻¹的字面版单列待审；只转录正文结论，不进入习题。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem shakeElimination :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (q p half : ℕ → MolecularDynamics.Chapter04Review.Q n) (rho : ℕ → MolecularDynamics.Chapter04Review.Q l),
    (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, MolecularDynamics.Chapter04Review.shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1))
```

### MD-4.3.5-SHAKEPositionOrder
```json
{
  "source_id": "MD-4.3.5-SHAKEPositionOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5",
  "printed_page": "161",
  "pdf_page": "183",
  "statement_latex": "There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.shakePositionOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正质量、C⁴势/约束/实际轨道、沿解非奇异Gram、相容两步初值；精确给真实有限区间位置误差O(h²)及分支存在，不把误差界作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem shakePositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    MolecularDynamics.Chapter04Review.constrainedSolution m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhon : ℕ → MolecularDynamics.Chapter04Review.Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → MolecularDynamics.Chapter04Review.shakePositionRelation m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2
```

