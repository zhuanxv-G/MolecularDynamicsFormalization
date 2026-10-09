# BATCH01 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2-HamiltonianODE
```json
{
  "source_id": "MD-2-HamiltonianODE",
  "kind": "definition",
  "label": null,
  "section": "2",
  "printed_page": "53",
  "pdf_page": "75",
  "statement_latex": "The challenge before us is to compute solutions of\n\\[\\dot{\\boldsymbol q}=M^{-1}\\boldsymbol p,\\qquad \\dot{\\boldsymbol p}=F(\\boldsymbol q)=-\\nabla U(\\boldsymbol q),\\]\nor, more compactly, with $\\boldsymbol z$ representing the collection of all positions and momenta,\n\\[\\dot{\\boldsymbol z}=f(\\boldsymbol z),\\qquad f(\\boldsymbol z)=J\\nabla H.\\tag{2.1}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\boldsymbol z=(\\boldsymbol q,\\boldsymbol p)$；$J$及$H$见同页下两条；n为配置坐标数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonianODE",
  "reusable_proofs": [],
  "extra_assumptions": [
    "原文ODE按时间域I逐点解释；只定义关系，不宣称解存在。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-001"
  ]
}
```
```lean
def hamiltonianODE {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t
```

### MD-2-Hamiltonian
```json
{
  "source_id": "MD-2-Hamiltonian",
  "kind": "definition",
  "label": null,
  "section": "2",
  "printed_page": "53",
  "pdf_page": "75",
  "statement_latex": "and $H=\\boldsymbol p^TM^{-1}\\boldsymbol p/2+U(\\boldsymbol q)$ is the Hamiltonian.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$M$为第1章固定对角质量矩阵；$\\boldsymbol q,\\boldsymbol p\\in\\mathbb R^n$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.mechanicalHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "固定对角质量的机械模型来自第1章；一般非对角矩阵不纳入此复用接口。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-002"
  ]
}
```
```lean
def mechanicalHamiltonian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n) :
    PhaseSpace n → ℝ := massHamiltonian m U
```

### MD-2-CanonicalJ
```json
{
  "source_id": "MD-2-CanonicalJ",
  "kind": "definition",
  "label": null,
  "section": "2",
  "printed_page": "53",
  "pdf_page": "75",
  "statement_latex": "where $J=\\begin{bmatrix}0&I\\\\-I&0\\end{bmatrix}$,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$I$为$n\\times n$单位阵；教材符号顺序$(q,p)$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.canonicalJ",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-003"
  ]
}
```
```lean
def canonicalJ (n : ℕ) : Matrix (Sum (Fin n) (Fin n)) (Sum (Fin n) (Fin n)) ℝ :=
  textbookJ n
```

### MD-2-Euler
```json
{
  "source_id": "MD-2-Euler",
  "kind": "definition",
  "label": null,
  "section": "2",
  "printed_page": "54",
  "pdf_page": "76",
  "statement_latex": "The simplest scheme is certainly Euler’s method which advances the solution from timestep to timestep by the formula\n\\[\\boldsymbol z_{n+1}=\\boldsymbol z_n+hf(\\boldsymbol z_n).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$h$为步长；下标$n$为时间步而非向量分量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.euler",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-004"
  ]
}
```
```lean
def euler {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (h : ℝ) (z : E) : E := z + h • f z
```

### MD-2-OneStep
```json
{
  "source_id": "MD-2-OneStep",
  "kind": "definition",
  "label": null,
  "section": "2",
  "printed_page": "54",
  "pdf_page": "76",
  "statement_latex": "Suppose that the system under study has a well defined flow map $\\mathcal F_t$ defined on the phase space (which is assumed to exclude any singular points of the potential energy function). The solution of the initial value problem, $\\dot{\\boldsymbol z}=f(\\boldsymbol z)$, $\\boldsymbol z(0)=\\boldsymbol\\zeta$, may be written $\\boldsymbol z(t;\\boldsymbol\\zeta)$ (with $\\boldsymbol z(0;\\boldsymbol\\zeta)=\\boldsymbol\\zeta$), and the flow-map $\\mathcal F_t$ satisfies $\\mathcal F_t(\\boldsymbol\\zeta)=\\boldsymbol z(t;\\boldsymbol\\zeta)$: A one-step method, starting from a given point, approximates a point on the solution trajectory at a given time $h$ units later. Such a method defines a map $\\mathcal G_h$ of the phase space as illustrated in Fig. 2.1.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal F_t(\\zeta)$为给定实际ODE解；$\\mathcal G_h$为单步近似映射；近似质量由后面的误差定义衡量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.numericalTrajectory",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-005",
    "CH02-006"
  ]
}
```
```lean
def numericalTrajectory {E : Type*} (G : ℝ → E → E) (h : ℝ) (ζ : E) (n : ℕ) : E :=
  (G h)^[n] ζ
```

