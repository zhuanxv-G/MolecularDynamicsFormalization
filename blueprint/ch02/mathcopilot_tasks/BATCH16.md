# BATCH16 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.3.3-PullbackOne
```json
{
  "source_id": "MD-2.3.3-PullbackOne",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "77",
  "pdf_page": "99",
  "statement_latex": "It is written $\\Phi^*\\psi$, so\n\\[(\\Phi^*\\psi_{\\boldsymbol z})(\\boldsymbol\\xi)=\\psi_{\\Phi(\\boldsymbol z)}(\\Phi'(\\boldsymbol z)\\boldsymbol\\xi).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Φ′为实际fderiv；底点在Φ(z)取值，非z。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_pullbackOne",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_pullbackOne {n : ℕ} (Φ : Q n → Q n) (α : oneForm n) : oneForm n :=
  fun z => (α (Φ z)).comp (fderiv ℝ Φ z)
```

### MD-2.3.3-PullbackTwo
```json
{
  "source_id": "MD-2.3.3-PullbackTwo",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "77",
  "pdf_page": "99",
  "statement_latex": "The pull-back of a differential 2-form $\\psi_1\\wedge\\psi_2$ is consequently defined as\n\\[\\Phi^*(\\psi_1\\wedge\\psi_2)=(\\Phi^*\\psi_1)\\wedge(\\Phi^*\\psi_2).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "两个方向都用Φ′(z)作用，底点Φ(z)；楔积乘法性为定义的双线性展开。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_pullbackTwo",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_pullbackTwo {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) (z u v : Q n) : ℝ :=
  A.val (Φ z) ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v)
```

### MD-2.3.3-PullbackMatrix
```json
{
  "source_id": "MD-2.3.3-PullbackMatrix",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.3",
  "printed_page": "77–78",
  "pdf_page": "99–100",
  "statement_latex": "Given a differential 2-form $\\psi_{\\boldsymbol z}$ represented by the matrix $A(\\boldsymbol z)=(a_{ij}(\\boldsymbol z))$, the pull-back of $\\psi_{\\boldsymbol z}$ under $\\Phi$ is defined by\n\\[\\Phi^*\\psi_{\\boldsymbol z}=\\sum_{ij}b_{ij}(\\boldsymbol z)dz_i\\wedge dz_j,\\]\nwhere the matrix $B(\\boldsymbol z)=(b_{ij}(\\boldsymbol z))$ is related to $A(\\boldsymbol z)$ by\n\\[B(\\boldsymbol z)=\\Phi'^T(\\boldsymbol z)A(\\Phi(\\boldsymbol z))\\Phi'(\\boldsymbol z).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "矩阵A在Φ(z)取值；系数双和归一问题另见GeneralTwoForm。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.pullbackMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem pullbackMatrix :
  ∀ n (Φ : Q n → Q n) (A : Q n → Matrix (Fin n) (Fin n) ℝ) z u v,
    dotProduct ((fderiv ℝ Φ z) u) ((A (Φ z)).mulVec ((fderiv ℝ Φ z) v)) =
      dotProduct u (((textbookCoordinateJacobian Φ z).transpose * A (Φ z) *
        textbookCoordinateJacobian Φ z).mulVec v)
```

### MD-2.3.3-PreservesForm
```json
{
  "source_id": "MD-2.3.3-PreservesForm",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "78",
  "pdf_page": "100",
  "statement_latex": "We say that a 2-form $\\psi$ is conserved under mapping $\\Phi$ if\n\\[\\Phi^*\\psi=\\psi.\\]\nIn coordinates, the conservation of the 2-form represented by matrix $A$ under a mapping $\\Phi$ means that\n\\[\\Phi'^TA\\Phi'=A.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "一般位置相关A的守恒式应DΦ(z)ᵀA(Φ(z))DΦ(z)=A(z)；原文省略底点，若只针对常矩阵才无歧义。"
    }
  ],
  "lean_decl": "MD.Ch02.bp_preservesTwoForm",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_preservesTwoForm {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) : Prop :=
  ∀ z u v, pullbackTwo Φ A z u v = A.val z u v
```

### MD-2.3.3-SymplecticIffForm
```json
{
  "source_id": "MD-2.3.3-SymplecticIffForm",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.3",
  "printed_page": "78",
  "pdf_page": "100",
  "statement_latex": "In the particular case of the symplectic 2-form $\\psi_S$, we have $A=J$, and the following condition for conservation under the mapping $\\Phi$\n\\[\\Phi'^TJ\\Phi'=J.\\tag{2.17}\\]\nA map that conserves the symplectic 2-form, or, in coordinates, satisfies (2.17), is termed a symplectic map.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.symplecticIffForm",
  "reusable_proofs": [
    "MolecularDynamics.isTextbookSymplecticMap_iff_preserves_form"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticIffForm {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    IsTextbookSymplecticMap Φ ↔ ContDiff ℝ 1 Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v
```

### MD-2.3.3-SymplecticDet
```json
{
  "source_id": "MD-2.3.3-SymplecticDet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.3",
  "printed_page": "78",
  "pdf_page": "100",
  "statement_latex": "Taking the determinant of both sides of (2.17), we have\n\\[\\det(\\Phi'^TJ\\Phi')=\\det(J)\\Rightarrow\\det(\\Phi'^T)\\det(J)\\det(\\Phi')=\\det(J),\\]\nhence\n\\[\\det(\\Phi')^2=1,\\]\nso $|\\det(\\Phi')|=1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A=实际Φ′；J可逆由标准块矩阵定义。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.symplecticDet",
  "reusable_proofs": [
    "MolecularDynamics.IsTextbookSymplectic.det_square",
    "MolecularDynamics.IsTextbookSymplectic.abs_det"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticDet {n : ℕ} (A : SymplecticCoordinateMatrix n) (hA : IsTextbookSymplectic A) :
    A.det^2=1 ∧ |A.det|=1
```

### MD-2.3.3-HamiltonDet
```json
{
  "source_id": "MD-2.3.3-HamiltonDet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.3",
  "printed_page": "78",
  "pdf_page": "100",
  "statement_latex": "If the system is Hamiltonian, the map is symplectic for all $t$, and the determinant will be a continuous function of $t$, so the cases of interest have $\\det(\\mathcal F_t')=+1$. The flow map of a Hamiltonian system is volume preserving.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同时保留真实流Jacobian det=1及所有可测集合体积保存，不遗漏原文最后一句。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonDet",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonDet {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (hH : ContDiff ℝ 2 H) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t)
    (hinit : (fun z => Φ (0,z))=id) :
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t,y)) z).det=1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (SymplecticCoordinates n), MeasurableSet S →
      volume ((fun z => Φ (t,z)) '' S)=volume S)
```

