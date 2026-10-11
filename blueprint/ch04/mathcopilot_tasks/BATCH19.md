# BATCH19 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.3.6-MShakeIteration
```json
{
  "source_id": "MD-4.3.6-MShakeIteration",
  "kind": "definition",
  "label": null,
  "section": "4.3.6",
  "printed_page": "164",
  "pdf_page": "186",
  "statement_latex": "M-Shake This is Newton-iteration-based implementation of SHAKE, using (4.18)–(4.19) to solve Eqs. (4.27)–(4.29).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Newton从0迭代k次；无需声称收敛，收敛已另列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.mShakeIteration",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def mShakeIteration {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (k : ℕ) := (MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[k] 0
```

### MD-4.3.6-SETTLE
```json
{
  "source_id": "MD-4.3.6-SETTLE",
  "kind": "definition",
  "label": null,
  "section": "4.3.6",
  "printed_page": "165",
  "pdf_page": "187",
  "statement_latex": "SETTLE The SETTLE method [274] is just the SHAKE approach applied to a small system combined with an exact solve of the nonlinear equations. It is usually applied to treat rigid bodies (as discussed in the following section).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.settleRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正文没有闭式算法细节，仅登记真实小系统residual=0关系；不发明SETTLE闭式或存在定理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def settleRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Prop := MolecularDynamics.Chapter04Review.projectionResidual m g q base η=0
```

### MD-4.3.6-LINCSInverse
```json
{
  "source_id": "MD-4.3.6-LINCSInverse",
  "kind": "definition",
  "label": null,
  "section": "4.3.6",
  "printed_page": "165",
  "pdf_page": "187",
  "statement_latex": "LINCS In solving the Eqs. (4.27)–(4.29) by Newton iteration, the largest cost and the most significant barrier to parallelization is the linear solve. The LINCS method [119,175] uses a series expansion to approximate the inverse matrix (which is valid only under certain conditions).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.lincsInverse",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]标准Neumann有限和Σ(j=0..k) C^j表达series inverse，正文没有印系数公式；收敛条件另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j
```

### MD-4.3.6-LINCSConvergence
```json
{
  "source_id": "MD-4.3.6-LINCSConvergence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.6",
  "printed_page": "165",
  "pdf_page": "187",
  "statement_latex": "The LINCS method [119,175] uses a series expansion to approximate the inverse matrix (which is valid only under certain conditions).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.lincsConvergence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确实际连续线性算子C.toLin'.toContinuousLinearMap的范数<1；不使用逐元素最大范数作为Neumann收敛资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lincsConvergence :
  ∀ l (C : Matrix (Fin l) (Fin l) ℝ),
  ‖C.toLin'.toContinuousLinearMap‖ < 1 → Tendsto (MolecularDynamics.Chapter04Review.lincsInverse C) atTop (𝓝 ((1-C)⁻¹))
```

