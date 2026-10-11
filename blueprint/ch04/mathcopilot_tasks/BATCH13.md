# BATCH13 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.3.3-ComponentPrinted
```json
{
  "source_id": "MD-4.3.3-ComponentPrinted",
  "kind": "definition",
  "label": null,
  "section": "4.3.3",
  "printed_page": "158",
  "pdf_page": "180",
  "statement_latex": "In general, we perform a sequence of updates\n\\[\\Delta\\Lambda_j=[\\nabla g_j(Q)^TM^{-1}G_j^1]^{-1}g_j(Q),\\qquad Q:=Q-M^{-1}G_n^j\\Delta\\Lambda_j,\\]\nas $j$ cycles repeatedly from $1$ to $m$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "一般分量式分母G_j^1疑为G_n^j的索引误写；原文不静默改。"
    }
  ],
  "lean_decl": "MD.Ch04.componentPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Gsup1是未定义印刷G_j^1的显式参数，未假设它等于已定义梯度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def componentPrinted {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```

### MD-4.3.3-ComponentConstraintStep
```json
{
  "source_id": "MD-4.3.3-ComponentConstraintStep",
  "kind": "definition",
  "label": null,
  "section": "4.3.3",
  "printed_page": "158",
  "pdf_page": "180",
  "statement_latex": "\\[\\Delta\\Lambda_1=[\\nabla g_1(Q)^TM^{-1}G_n^1]^{-1}g_1(Q).\\]\nWe then update $Q$ by\n\\[Q:=Q-M^{-1}G_n^1\\Delta\\Lambda_1.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.componentConstraintStep",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一般j采用已定义Gn^j=grad gj(qn)，取非零分母才是可用步骤；原一般式索引疑误由ComponentPrinted保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (j : Fin l) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```

### MD-4.3.3-ComponentSweep
```json
{
  "source_id": "MD-4.3.3-ComponentSweep",
  "kind": "definition",
  "label": null,
  "section": "4.3.3",
  "printed_page": "158",
  "pdf_page": "180",
  "statement_latex": "and continue to update $\\Lambda_2$ in the same manner (using the second constraint). In general, we perform a sequence of updates ... as $j$ cycles repeatedly from $1$ to $m$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "检查全部分量或残差的停止建议为实现背景，不以定义证明收敛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.componentSweep",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一次完整顺序sweep，使用上一条统一Gn索引；多轮为其真实函数迭代。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def componentSweep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (List.finRange l).foldl (fun Qcur j => MolecularDynamics.Chapter04Review.componentConstraintStep m g q Qcur j) Qnow
```

