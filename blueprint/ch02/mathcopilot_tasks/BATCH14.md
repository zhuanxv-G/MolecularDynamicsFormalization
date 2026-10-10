# BATCH14 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.3.2-LinearDivergence
```json
{
  "source_id": "MD-2.3.2-LinearDivergence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.2",
  "printed_page": "74–75",
  "pdf_page": "96–97",
  "statement_latex": "Consider a linear differential equation system in $\\mathbb R^m$,\n\\[\\dot{\\boldsymbol z}=S\\boldsymbol z,\\]\nfor some matrix $S\\in\\mathbb R^{m\\times m}$. The condition for the flow of this system to conserve volume is just that the trace of $S$ (which is the divergence of the vector field $f(\\boldsymbol z)=S\\boldsymbol z$) be zero.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "div f=tr S；体积结论由Liouville承担，逆向需线性流行列式公式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.linearDivergence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际全时C²解族Φ，Φ0=id并满足真实线性ODE；只量化可测T。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem linearDivergence : ∀ n (S : Matrix (Fin n) (Fin n) ℝ)
    (Φ : ℝ × Q n → Q n), ContDiff ℝ 2 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t z, HasDerivAt (fun s => Φ (s,z)) (S.mulVec (Φ (t,z))) t) →
    (∀ z, divergence S.mulVec z=S.trace) ∧
    ((∀ t, ∀ T : Set (Q n), MeasurableSet T →
      volume ((fun z => Φ (t,z)) '' T)=volume T) ↔ S.trace=0)
```

### MD-2.3.2-LinearEuler
```json
{
  "source_id": "MD-2.3.2-LinearEuler",
  "kind": "definition",
  "label": null,
  "section": "2.3.2",
  "printed_page": "75",
  "pdf_page": "97",
  "statement_latex": "Applying Euler’s method to the same system results in\n\\[\\boldsymbol z_{n+1}=\\boldsymbol z_n+hS\\boldsymbol z_n=(I+hS)\\boldsymbol z_n,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "S有限实矩阵；I为单位阵。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_linearEuler",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_linearEuler {n : ℕ} (S : Matrix (Fin n) (Fin n) ℝ) (h : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  1 + h • S
```

### MD-2.3.2-EulerVolumePrinted
```json
{
  "source_id": "MD-2.3.2-EulerVolumePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.2",
  "printed_page": "75",
  "pdf_page": "97",
  "statement_latex": "and the condition for Euler’s method to conserve volume is that $\\det(I+hS)=1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "体积只要求|det|=1；原文省略正向/足够小步长条件。反射在大步长可保持体积但det=-1。"
    }
  ],
  "lean_decl": "MD.Ch02.eulerVolumePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem eulerVolumePrinted : ∀ n (S : Matrix (Fin n) (Fin n) ℝ) h,
    (∀ T : Set (Q n), MeasurableSet T →
      volume ((linearEuler S h).mulVec '' T)=volume T) ↔ (linearEuler S h).det=1
```

### MD-2.3.2-EulerVolumeCounterexample
```json
{
  "source_id": "MD-2.3.2-EulerVolumeCounterexample",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.2",
  "printed_page": "75",
  "pdf_page": "97",
  "statement_latex": "The conditions for volume preservation by the flow map and its Euler approximation are essentially unrelated. Thus Euler’s method does not in general conserve phase space volume (it conserves volume only in very special cases—see Exercise 6).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.eulerVolumeCounterexample",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem eulerVolumeCounterexample :
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → (linearEuler S h).det ≠ 1
```

### MD-2.3.2-AsymmetricEuler
```json
{
  "source_id": "MD-2.3.2-AsymmetricEuler",
  "kind": "definition",
  "label": null,
  "section": "2.3.2",
  "printed_page": "75",
  "pdf_page": "97",
  "statement_latex": "the asymmetrical variant of Euler’s method defined by\n\\[u_{n+1}=u_n+hf(u_{n+1},v_n),\\qquad v_{n+1}=v_n+hg(u_{n+1},v_n).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "u′=f(u,v)，v′=g(u,v)；divergence free为fu+gv=0；只定义隐式关系，不宣称全球求解器。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_asymmetricEulerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_asymmetricEulerRelation (f g : ℝ → ℝ → ℝ) (h u v U V : ℝ) : Prop :=
  U = u + h*f U v ∧ V = v + h*g U v
```

### MD-2.3.2-AsymmetricJacobian
```json
{
  "source_id": "MD-2.3.2-AsymmetricJacobian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.2",
  "printed_page": "75",
  "pdf_page": "97",
  "statement_latex": "Solving for the various entries we have\n\\[\\mathcal G_h'=\\begin{bmatrix}1/(1-hf_u)&hf_v/(1-hf_u)\\\\hg_u/(1-hf_u)&1+hg_v+h^2g_uf_v/(1-hf_u)\\end{bmatrix},\\]\nand calculating the determinant of the Jacobian results in\n\\[\\det\\mathcal G_h'=\\frac{1+hg_v}{1-hf_u}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.asymmetricDet",
  "reusable_proofs": [],
  "extra_assumptions": [
    "f,g及实际隐式解映射Ψ C¹；分母1-hfu≠0；偏导在(U,v)取值。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem asymmetricDet :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    ∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0 →
      (textbookCoordinateJacobian Ψ z) =
        !![(1/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) : ℝ),
          h*deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0));
          h*deriv (fun u => g u (z 1)) (Ψ z 0)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)),
          1+h*deriv (g (Ψ z 0)) (z 1)+h^2*deriv (fun u => g u (z 1)) (Ψ z 0)*
            deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0))] ∧
      (textbookCoordinateJacobian Ψ z).det =
        (1+h*deriv (g (Ψ z 0)) (z 1))/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0))
```

### MD-2.3.2-AsymmetricArea
```json
{
  "source_id": "MD-2.3.2-AsymmetricArea",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.2",
  "printed_page": "75–76",
  "pdf_page": "97–98",
  "statement_latex": "In the event that the vector field is divergence free, we have $f_u+g_v=0$ which implies that the numerator and denominator are identical, and it follows that $\\det\\mathcal G_h'=1$. Thus the asymmetric variant of the Euler method is area preserving, even though the standard Euler method is not.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.asymmetricArea",
  "reusable_proofs": [],
  "extra_assumptions": [
    "f,g及实际解映射Ψ C¹，分母处处非零；行列式1给局部面积保存，整集需单射域。",
    "[EXTRA]Ψ实际单射，保证整集面积换元；Jacobian1本身仅给局部面积。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem asymmetricArea :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    (∀ u v, deriv (fun x => f x v) u + deriv (g u) v = 0) →
    (∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0) →
    Function.Injective Ψ →
    (∀ z, (textbookCoordinateJacobian Ψ z).det = 1) ∧
    (∀ T : Set (Q 2), MeasurableSet T → volume (Ψ '' T)=volume T)
```

