# BATCH08 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.2.2-EliminateVelocity
```json
{
  "source_id": "MD-2.2.2-EliminateVelocity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.2",
  "printed_page": "65",
  "pdf_page": "87",
  "statement_latex": "The derivation of the Störmer form from the velocity Verlet form is straightforward: write down two consecutive steps of (2.5)–(2.7) then eliminate velocities.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.velocityVerletStormer",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.velocityVerletStormer_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem velocityVerletStormer :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h (a b c : Z n),
    b = velocityVerlet m F h a → c = velocityVerlet m F h b →
    stormerRelation m F h a.1 b.1 c.1
```

### MD-2.2.2-MomentumVerlet
```json
{
  "source_id": "MD-2.2.2-MomentumVerlet",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "65",
  "pdf_page": "87",
  "statement_latex": "The most straightforward rewriting of the Verlet method is to put the equations and the discretization in Hamiltonian form, i.e. introducing momenta $\\boldsymbol p=M\\boldsymbol v$, and thus $\\boldsymbol p_n=M\\boldsymbol v_n$, which results in the flow map approximation (taking us from any point in phase space $(\\boldsymbol q,\\boldsymbol p)$ to a new point $(\\boldsymbol Q,\\boldsymbol P)$):\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol p+\\frac{h^2}{2}M^{-1}F(\\boldsymbol q),\\qquad\\boldsymbol P=\\boldsymbol p+\\frac h2[F(\\boldsymbol q)+F(\\boldsymbol Q)].\\tag{2.8}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "p为动量；“Alternatively”后半踢、漂移、半踢与此展开式代数等价。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_verlet",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
```

### MD-2.2.2-Leapfrog
```json
{
  "source_id": "MD-2.2.2-Leapfrog",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "65",
  "pdf_page": "87",
  "statement_latex": "Returning to (2.5)–(2.7), write out the formulas for two successive steps ($(\\boldsymbol q_{n-1},\\boldsymbol v_{n-1})\\mapsto(\\boldsymbol q_n,\\boldsymbol v_n)$ and $(\\boldsymbol q_n,\\boldsymbol v_n)\\mapsto(\\boldsymbol q_{n+1},\\boldsymbol v_{n+1})$) and note that, from\n\\[\\boldsymbol v_n=\\boldsymbol v_{n-1/2}+(h/2)M^{-1}F_n,\\]\none has\n\\[\\boldsymbol v_{n+1/2}=\\boldsymbol v_{n-1/2}+hM^{-1}F_n,\\qquad\\boldsymbol q_{n+1}=\\boldsymbol q_n+h\\boldsymbol v_{n+1/2}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "第二分量代表交错半步速度v(n-1/2)。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_leapfrog",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_leapfrog {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vnew := z.2 + h • invMass m (F z.1)
  (z.1 + h • vnew, vnew)
```

### MD-2.2.2-LeapfrogInit
```json
{
  "source_id": "MD-2.2.2-LeapfrogInit",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "65",
  "pdf_page": "87",
  "statement_latex": "It is necessary to define an initialization procedure for $\\boldsymbol v_{-1/2}$:\n\\[\\boldsymbol v_{-1/2}=\\boldsymbol v_0-(h/2)M^{-1}F(\\boldsymbol q_0).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "q0,v0为实际初值。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_leapfrogInitialize",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_leapfrogInitialize {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 - (h/2) • invMass m (F z.1)
```

### MD-2.2.2-LeapfrogReconstruct
```json
{
  "source_id": "MD-2.2.2-LeapfrogReconstruct",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "65",
  "pdf_page": "87",
  "statement_latex": "And it is also necessary to use, at any subsequent step,\n\\[\\boldsymbol v_n=\\boldsymbol v_{n-1/2}+(h/2)M^{-1}F_n,\\]\nif $\\boldsymbol q_n,\\boldsymbol v_n$ are both needed, e.g. for the evaluation of the energy or other velocity-dependent observable.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Fn=F(qn)，第二分量是半步速度。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_leapfrogReconstruct",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_leapfrogReconstruct {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 + (h/2) • invMass m (F z.1)
```

