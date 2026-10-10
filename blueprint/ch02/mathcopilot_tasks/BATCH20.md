# BATCH20 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.3.7-Adjoint
```json
{
  "source_id": "MD-2.3.7-Adjoint",
  "kind": "definition",
  "label": null,
  "section": "2.3.7",
  "printed_page": "81",
  "pdf_page": "103",
  "statement_latex": "Given any numerical integrator $\\mathcal G_h$, consider the map\n\\[\\mathcal G_h^*=\\mathcal G_{-h}^{-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_adjoint",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]方法G每个可用h为实际Equiv.Perm；只在负步可逆时定义伴随，不能宣称任意步映射天然可逆。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def bp_adjoint {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```

### MD-2.3.7-FlowSelfAdjoint
```json
{
  "source_id": "MD-2.3.7-FlowSelfAdjoint",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.7",
  "printed_page": "82",
  "pdf_page": "104",
  "statement_latex": "For the flow map $\\mathcal F_h$, we know that the inverse map is precisely $\\mathcal F_{-h}$, so $\\mathcal F_h^*=\\mathcal F_h$, i.e. the flow map is in the normal sense “self-adjoint,” i.e. symmetric.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.flowSelfAdjoint",
  "reusable_proofs": [
    "MolecularDynamics.textbookFlowMethod_isSelfAdjoint"
  ],
  "extra_assumptions": [
    "[EXTRA]给定全球Flow群；原文局部流若无全球存在，须在正负步都可用域解释，未宣称所有ODE有全球流。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem flowSelfAdjoint {E : Type*} [TopologicalSpace E]
    (F : Flow ℝ E) : textbookAdjointMethod (textbookFlowMethod F) = textbookFlowMethod F
```

### MD-2.3.7-BackwardEuler
```json
{
  "source_id": "MD-2.3.7-BackwardEuler",
  "kind": "definition",
  "label": null,
  "section": "2.3.7",
  "printed_page": "82",
  "pdf_page": "104",
  "statement_latex": "The adjoint method is defined by\n\\[\\boldsymbol Z=\\boldsymbol z+hf(\\boldsymbol Z),\\]\nand where the first was explicit, the second is implicit (it is the so-called backward Euler method).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "只给隐式关系，不把全球唯一解作未证事实。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_backwardEulerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_backwardEulerRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w = z + h • f w
```

### MD-2.3.7-EulerAdjoint
```json
{
  "source_id": "MD-2.3.7-EulerAdjoint",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.7",
  "printed_page": "82",
  "pdf_page": "104",
  "statement_latex": "In particular, consider Euler’s method\n\\[\\boldsymbol Z=\\boldsymbol z+hf(\\boldsymbol z).\\]\nThe adjoint method is defined by\n\\[\\boldsymbol Z=\\boldsymbol z+hf(\\boldsymbol Z),\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.eulerAdjoint",
  "reusable_proofs": [
    "MolecularDynamics.euler_adjoint_iff_backward"
  ],
  "extra_assumptions": [
    "[EXTRA]给定负步Euler实际双射；G(-h)与Euler映射逐点一致，不假设所有f/h可逆。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem eulerAdjoint (f : E → E) (G : ℝ → Equiv.Perm E)
    (h : ℝ) (hG : ∀ Z, G (-h) Z = eulerStep f (-h) Z) (z Z : E) :
    textbookAdjointMethod G h z = Z ↔ Z = z + h • f Z
```

### MD-2.3.7-AdjointSymplecticEuler
```json
{
  "source_id": "MD-2.3.7-AdjointSymplecticEuler",
  "kind": "definition",
  "label": null,
  "section": "2.3.7",
  "printed_page": "82",
  "pdf_page": "104",
  "statement_latex": "Its adjoint method has a similar structure:\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol p,\\tag{2.22}\\]\n\\[\\boldsymbol P=\\boldsymbol p+hF(\\boldsymbol Q).\\tag{2.23}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际辛Euler可逆，逆负步得到drift再kick；定义体与两个坐标式一致。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_adjointSymplecticEuler",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def bp_adjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h
```

### MD-2.3.7-AdjointInvolution
```json
{
  "source_id": "MD-2.3.7-AdjointInvolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.7",
  "printed_page": "82",
  "pdf_page": "104",
  "statement_latex": "the adjoint of the adjoint is the original method:\n\\[\\mathcal G_h^{**}=[\\mathcal G_{-h}^*]^{-1}=[\\mathcal G_h^{-1}]^{-1}=\\mathcal G_h.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.adjointInvolution",
  "reusable_proofs": [
    "MolecularDynamics.textbookAdjointMethod_involutive"
  ],
  "extra_assumptions": [
    "实际可逆步方法族Equiv.Perm；负步及双逆确实存在。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem adjointInvolution {E : Type*} (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookAdjointMethod G) = G
```

