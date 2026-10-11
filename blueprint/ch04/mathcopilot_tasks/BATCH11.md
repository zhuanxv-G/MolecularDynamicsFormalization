# BATCH11 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.3.2-PositionEulerPrinted
```json
{
  "source_id": "MD-4.3.2-PositionEulerPrinted",
  "kind": "definition",
  "label": "(4.14)–(4.16)",
  "section": "4.3.2",
  "printed_page": "156",
  "pdf_page": "178",
  "statement_latex": "A simple example of such a method is the constrained Symplectic Euler-like method\n\\[q_{n+1}=q_n+hM^{-1}p_{n+1},\\tag{4.14}\\]\n\\[p_{n+1}=p_n-hF_n-hg'(q_n)^T\\lambda_n,\\tag{4.15}\\]\n\\[0=g(q_{n+1}).\\tag{4.16}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "印刷Fn负号与后文F=−grad U/+hF用法的约定需裁定。"
    }
  ],
  "lean_decl": "MD.Ch04.positionEulerPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def positionEulerPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2-h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### MD-4.3.2-PositionEulerForceConvention
```json
{
  "source_id": "MD-4.3.2-PositionEulerForceConvention",
  "kind": "definition",
  "label": null,
  "section": "4.3.2",
  "printed_page": "156",
  "pdf_page": "178",
  "statement_latex": "A simple example of such a method is the constrained Symplectic Euler-like method",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.positionEulerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]采用F=−grad U的统一力版本，动量+hF；字面−hFn原式仍保留在相邻条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def positionEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### MD-4.3.2-HiddenEulerError
```json
{
  "source_id": "MD-4.3.2-HiddenEulerError",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.2",
  "printed_page": "156",
  "pdf_page": "178",
  "statement_latex": "The hidden constraint $g'(q_0)M^{-1}p_0=0$ will be violated, but one hopes it remains approximately satisfied. The justification for the latter assumption is that if we expand $g$ in a Taylor series, we may write\n\\[g(q_n)\\approx g(q_{n+1})+g'(q_{n+1})(q_n-q_{n+1}).\\]\nThen since we maintain $g(q_n)=0$ for all $n$, we have\n\\[g'(q_{n+1})M^{-1}p_{n+1}\\approx0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.hiddenEulerError",
  "reusable_proofs": [],
  "extra_assumptions": [
    "C²约束与C²实际出点小步分支，out0=z，初位置合法；将approx0定量化为小正h的一致O(h)，不把隐藏误差作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hiddenEulerError :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (out : ℝ → MolecularDynamics.Chapter04Review.Z n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 out → out 0=z →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, MolecularDynamics.Chapter04Review.positionEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (out h) (rho h)) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      ‖textbookConstraintJacobian g (out h).1 *ᵥ MolecularDynamics.Chapter04Review.invMass m (out h).2‖ ≤ C*h
```

### MD-4.3.2-ProjectionResidual
```json
{
  "source_id": "MD-4.3.2-ProjectionResidual",
  "kind": "definition",
  "label": "(4.17)",
  "section": "4.3.2",
  "printed_page": "156",
  "pdf_page": "178",
  "statement_latex": "To solve the Eqs. (4.14)–(4.16), insert the second in the first and the first then in the third to obtain the simplified equation\n\\[g(Q_n-M^{-1}G_n^T\\Lambda)=0,\\tag{4.17}\\]\nwhere\n\\[Q_n=q_n+hM^{-1}p_n-h^2M^{-1}F_n,\\qquad G_n=g'(q_n),\\qquad\\Lambda=h^2\\lambda_n.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "q为旧位置，base为所给Qn，η=Λ；关系只定义残差，不宣称非线性根存在。Fn符号原式已单列，不用一个任意base假装完成动量消元证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.projectionResidual",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```

### MD-4.3.2-ProjectionJacobian
```json
{
  "source_id": "MD-4.3.2-ProjectionJacobian",
  "kind": "definition",
  "label": null,
  "section": "4.3.2",
  "printed_page": "157",
  "pdf_page": "179",
  "statement_latex": "$R^{(l)}\\Delta\\Lambda^{(l)}=g(Q^{(l)}),\\qquad R^{(l)}\\stackrel{\\mathrm{def}}=g'(Q^{(l)})M^{-1}G_n^T$,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "R是负的残差Jacobian（Q=base−M⁻¹Gᵀη）；保留原Newton加号，不误称R=+Dη残差。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.projectionJacobian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```

### MD-4.3.2-NewtonConstraint
```json
{
  "source_id": "MD-4.3.2-NewtonConstraint",
  "kind": "definition",
  "label": "(4.18)–(4.19)",
  "section": "4.3.2",
  "printed_page": "157",
  "pdf_page": "179",
  "statement_latex": "The simplest is Gauss-Newton iteration, which may be written\n\\[\\Lambda^{(l+1)}=\\Lambda^{(l)}+[g'(Q^{(l)})M^{-1}G_n^T]^{-1}g(Q^{(l)}),\\tag{4.18}\\]\n\\[Q^{(l)}:=Q_n-M^{-1}G_n^T\\Lambda^{(l)},\\tag{4.19}\\]\nwhich might be initialized with $\\Lambda^{(0)}=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际交叉Gram逆及残差，矩阵非奇异时才是合法求解步；初始化η0=0。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.newtonConstraint",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base η)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η
```

### MD-4.3.2-FrozenNewtonConstraint
```json
{
  "source_id": "MD-4.3.2-FrozenNewtonConstraint",
  "kind": "definition",
  "label": null,
  "section": "4.3.2",
  "printed_page": "157",
  "pdf_page": "179",
  "statement_latex": "we may be able to fix $R$ at the beginning of the timestep, factor it once only, and then solve at each iteration with the same factors. Moreover, in case we have chosen $\\Lambda^{(0)}=0$, we have\n\\[R^{(0)}=G_nM^{-1}G_n^T,\\]\nwhich is a symmetric matrix,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "固定η0=0处的R作为每步矩阵；但Q(0)=base，不无条件等G(q)M⁻¹G(q)ᵀ；原文所写初始Gram等式另列疑点。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "R(0)=g′(Qn)M⁻¹Gnᵀ，一般不是GnM⁻¹Gnᵀ；只有Qn=qn或冻结Jacobian到旧位置时相同。"
    }
  ],
  "lean_decl": "MD.Ch04.frozenNewtonConstraint",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def frozenNewtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η
```

### MD-4.3.2-NewtonQuadratic
```json
{
  "source_id": "MD-4.3.2-NewtonQuadratic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.2",
  "printed_page": "157",
  "pdf_page": "179",
  "statement_latex": "When the solution is unique, the constraints sufficiently smooth, and the determinant of $R$ is bounded well away from zero, Newton’s method has a very rapid asymptotic convergence property. It is possible to show that, if $\\Lambda_*$ is the solution of (4.17), then sufficiently near the zero we have\n\\[\\|\\Lambda^{(l+1)}-\\Lambda_*\\|\\le C\\|\\Lambda^{(l)}-\\Lambda_*\\|^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.newtonQuadratic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "局部C²约束、真实残差root=0及真实R(root) det≠0；结论给存在邻域/二次界，不假设Newton误差结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem newtonQuadratic :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base root).det ≠ 0 → ∃ C > 0, ∃ δ > 0,
    ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ → ‖MolecularDynamics.Chapter04Review.newtonConstraint m g q base η-root‖ ≤ C*‖η-root‖^2
```

