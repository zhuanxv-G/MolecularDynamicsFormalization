# BATCH15 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.3.3-SymplecticMap
```json
{
  "source_id": "MD-2.3.3-SymplecticMap",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "76",
  "pdf_page": "98",
  "statement_latex": "Let $m=2N_c$. A symplectic map $\\Phi:\\mathbb R^m\\to\\mathbb R^m$ is one that preserves the symplectic differential 2-form. The simplest way to write this is as the following algebraic condition on the Jacobian matrix of $\\Phi$:\n\\[\\Phi'^TJ\\Phi'=J.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "m=2Nc，Jacobian是真实Fréchet导数矩阵；J=[[0,I],[-I,0]]，p.53/PDF75；资格Differentiable。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_IsSymplecticMap",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_IsSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```

### MD-2.3.3-OneForm
```json
{
  "source_id": "MD-2.3.3-OneForm",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "76",
  "pdf_page": "98",
  "statement_latex": "A 1-form $\\alpha$ defined on $\\mathbb R^m$ is a family of linear mappings from $\\mathbb R^m$ to $\\mathbb R$, defined for each point of $\\mathbb R^m$. Let $\\boldsymbol a:\\mathbb R^m\\to\\mathbb R^m$, then we may define a one-form associated to this vector by $\\alpha(\\boldsymbol x)(\\boldsymbol\\xi)=\\boldsymbol a(\\boldsymbol x)^T\\boldsymbol\\xi$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "有限维线性泛函自动连续；a(x)对应线性泛函的坐标表示。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.oneFormFamily",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def oneFormFamily (n : ℕ) := Q n → Q n →L[ℝ] ℝ
```

### MD-2.3.3-Differential
```json
{
  "source_id": "MD-2.3.3-Differential",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "76",
  "pdf_page": "98",
  "statement_latex": "The differential of a function $g:\\mathbb R^m\\to\\mathbb R$, denoted $dg$, is a family of linear mappings (one for each point in phase space) from vectors $\\boldsymbol\\xi\\in\\mathbb R^m$ into the reals defined by\n\\[dg(\\boldsymbol q,\\boldsymbol p)(\\boldsymbol\\xi)=\\nabla g(\\boldsymbol q,\\boldsymbol p)^T\\boldsymbol\\xi.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际fderiv；有限维导数=梯度与方向内积。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_differential",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_differential {n : ℕ} (g : Q n → ℝ) : oneForm n := fderiv ℝ g
```

### MD-2.3.3-CoordinateDifferentials
```json
{
  "source_id": "MD-2.3.3-CoordinateDifferentials",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "76",
  "pdf_page": "98",
  "statement_latex": "So, denoting the $i$th position coordinate by $q_i$, we have $dq_i(\\boldsymbol\\xi)=\\xi_i$; the differential is thus an example of a 1-form.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "dp_i(ξ)=ξ_(i+Nc)由p.77/PDF99同页楔积式补齐；坐标分拆按Sum.inl/inr。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.coordinateDifferentials",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def coordinateDifferentials (n : ℕ) :
    (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) × (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) :=
  (textbookDq,textbookDp)
```

### MD-2.3.3-Wedge
```json
{
  "source_id": "MD-2.3.3-Wedge",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "76",
  "pdf_page": "98",
  "statement_latex": "It is written $\\alpha\\wedge\\beta$ and is defined, for vectors $\\boldsymbol\\xi,\\boldsymbol\\eta\\in\\mathbb R^m$ by\n\\[\\alpha\\wedge\\beta(\\boldsymbol\\xi,\\boldsymbol\\eta)=\\alpha(\\boldsymbol\\xi)\\beta(\\boldsymbol\\eta)-\\alpha(\\boldsymbol\\eta)\\beta(\\boldsymbol\\xi).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "在固定底点取1-form的两个线性泛函；双线性反对称。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_wedge",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_wedge {Nc : ℕ} (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) α β -
    LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) β α

@[simp] theorem textbookWedgeOneForms_apply {Nc : ℕ}
    (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) (u v : SymplecticCoordinates Nc) :
    textbookWedgeOneForms α β u v = α u * β v - α v * β u := by
  change α u * β v - β u * α v = _
  ring
```

### MD-2.3.3-SymplecticForm
```json
{
  "source_id": "MD-2.3.3-SymplecticForm",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "77",
  "pdf_page": "99",
  "statement_latex": "Summing these terms results in the symplectic 2-form, denoted $\\psi_S$:\n\\[\\psi_S=\\sum_{i=1}^{N_c}dq_i\\wedge dp_i(\\boldsymbol\\xi,\\boldsymbol\\eta)=\\boldsymbol\\xi^T\\left(\\sum_{i=1}^{N_c}J^{(i)}\\right)\\boldsymbol\\eta=\\boldsymbol\\xi^TJ\\boldsymbol\\eta.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "J^(i)仅(i,i+Nc)=1、(i+Nc,i)=-1；教材J同p.53/PDF75。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_symplecticForm",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def bp_symplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```

### MD-2.3.3-FormSumWedges
```json
{
  "source_id": "MD-2.3.3-FormSumWedges",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.3",
  "printed_page": "77",
  "pdf_page": "99",
  "statement_latex": "The wedge product of the coordinate differentials $dq_i,dp_i$ may be written\n\\[dq_i\\wedge dp_i(\\boldsymbol\\xi,\\boldsymbol\\eta)=\\xi_i\\eta_{i+N_c}-\\xi_{i+N_c}\\eta_i=\\boldsymbol\\xi^TJ^{(i)}\\boldsymbol\\eta.\\]\nSumming these terms results in the symplectic 2-form, denoted $\\psi_S$:\n\\[\\psi_S=\\sum_{i=1}^{N_c}dq_i\\wedge dp_i(\\boldsymbol\\xi,\\boldsymbol\\eta)=\\boldsymbol\\xi^TJ\\boldsymbol\\eta.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "J^(i)单项坐标矩阵公式来自dq/dp真实定义，和式为完整最终结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.formSumWedges",
  "reusable_proofs": [
    "MolecularDynamics.textbookSymplecticForm_eq_sum_wedges"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem formSumWedges (Nc : ℕ) :
    textbookSymplecticForm Nc =
      ∑ i : Fin Nc, textbookWedgeOneForms (textbookDq i) (textbookDp i)
```

### MD-2.3.3-GeneralTwoForm
```json
{
  "source_id": "MD-2.3.3-GeneralTwoForm",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "77",
  "pdf_page": "99",
  "statement_latex": "In general, a differential 2-form $\\psi$ is represented in coordinates by\n\\[\\psi_{\\boldsymbol z}=\\sum_{i,j}a_{ij}(\\boldsymbol z)\\,dz_i\\wedge dz_j,\\]\nwith matrix of coefficients $A(\\boldsymbol z)=(a_{ij}(\\boldsymbol z))$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "双和系数A的实际双线性矩阵是A-Aᵀ；若A反对称为2A。后文直接用A作矩阵表示存在因子约定疑点。"
    }
  ],
  "lean_decl": "MD.Ch02.coefficientTwoForm",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def coefficientTwoForm {n : ℕ} (A : Q n → Matrix (Fin n) (Fin n) ℝ)
    (z u v : Q n) : ℝ :=
  ∑ i, ∑ j, A z i j * (u i*v j-v i*u j)
```

