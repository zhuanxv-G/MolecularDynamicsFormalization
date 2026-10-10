# BATCH12 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.3.1-Divergence
```json
{
  "source_id": "MD-2.3.1-Divergence",
  "kind": "definition",
  "label": null,
  "section": "2.3.1",
  "printed_page": "72",
  "pdf_page": "94",
  "statement_latex": "the divergence of $f$ vanishes, i.e.\n\\[\\nabla\\cdot f=\\sum_{i=1}^m\\frac{\\partial f_i}{\\partial z_i}=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "div f为实际Jacobian的迹；f C¹。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_divergence",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_divergence {n : ℕ} (f : Q n → Q n) (z : Q n) : ℝ := (textbookCoordinateJacobian f z).trace
```

### MD-2.3.1-Liouville
```json
{
  "source_id": "MD-2.3.1-Liouville",
  "kind": "unnumbered_claim",
  "label": "Liouville’s theorem",
  "section": "2.3.1",
  "printed_page": "72",
  "pdf_page": "94",
  "statement_latex": "Consider a set of points $S(t)$ in phase space with evolution associated to a differential equation $\\dot{\\boldsymbol z}=f(\\boldsymbol z)$ described by the flow map $\\mathcal F_t(S(0))=S(t)$. Liouville’s theorem [16] states that the volume of such a set is invariant with respect to $t$ if the divergence of $f$ vanishes,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.liouville",
  "reusable_proofs": [
    "MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]实际解族Φ联合C²（原文未重复此较强正则性）；f C¹、Φ0=id、τ>0及实际时间ODE；只对可测S表达Lebesgue体积。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem liouville
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set ((Fin n) → ℝ)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s
```

### MD-2.3.1-HamiltonDivergence
```json
{
  "source_id": "MD-2.3.1-HamiltonDivergence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "72",
  "pdf_page": "94",
  "statement_latex": "It is a simple exercise to show that for a Hamiltonian system the divergence vanishes, since\n\\[\\nabla\\cdot f=\\sum_{i=1}^{N_c}\\frac{\\partial^2 H}{\\partial q_i\\partial p_i}-\\sum_{i=1}^{N_c}\\frac{\\partial^2 H}{\\partial p_i\\partial q_i}=0,\\]\nby equality of mixed partials.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonDivergence",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianVectorField_divergence_zero"
  ],
  "extra_assumptions": [
    "H C²，保证混合偏导对称。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonDivergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0
```

### MD-2.3.1-HamiltonVolume
```json
{
  "source_id": "MD-2.3.1-HamiltonVolume",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "72",
  "pdf_page": "94",
  "statement_latex": "Thus Hamiltonian systems always have volume preserving flows.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "流为实际Hamilton向量场的解族；完整体积结论覆盖闭时间窗每个t及每个可测S。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonVolume",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]Φ联合C²；H C²、Φ0=id，τ>0；可测集S。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonVolume {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (SymplecticCoordinates Nc)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s
```

### MD-2.3.1-VolumeChange
```json
{
  "source_id": "MD-2.3.1-VolumeChange",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "73",
  "pdf_page": "95",
  "statement_latex": "If we view the map $\\mathcal F_t$ as a change of variables, we have\n\\[\\operatorname{Vol}(S(t))=\\int_S |D|\\,d\\omega,\\]\nwhere $D=\\det\\left(\\frac{\\partial\\mathcal F_t}{\\partial\\boldsymbol z}\\right)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.volumeChange",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Φ C¹单射，可测S；正则流的固定时刻映射具备这些资格；真实Lebesgue体积和lintegral。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem volumeChange :
  ∀ n (Φ : Q n → Q n) (S : Set (Q n)), ContDiff ℝ 1 Φ → Function.Injective Φ → MeasurableSet S →
    volume (Φ '' S) = ∫⁻ z in S, ENNReal.ofReal |(textbookCoordinateJacobian Φ z).det| ∂volume
```

### MD-2.3.1-VariationalPrinted
```json
{
  "source_id": "MD-2.3.1-VariationalPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "73",
  "pdf_page": "95",
  "statement_latex": "To understand where Liouville’s theorem comes from, recall that the variational equations of the last chapter are a system of ordinary differential equations for $W(t)=\\mathcal F_t'(\\boldsymbol z(t))$:\n\\[\\frac{\\mathrm dW}{\\mathrm dt}=f'(\\boldsymbol z(t))W.\\]\nThus\n\\[\\dot W W^{-1}=f'(\\boldsymbol z(t)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文W在z(t)取Jacobian，而变分矩阵应在固定初值ζ取Jacobian；沿移动取值点会多一链式项。后式还需要W可逆，局部流可给但不能忽略域。"
    }
  ],
  "lean_decl": "MD.Ch02.variationalPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem variationalPrinted : ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ ζ,
    flowC1 f Φ τ → ∀ t ∈ Ioo 0 τ,
    HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookCoordinateJacobian f (Φ (t,ζ)) *
        textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t ∧
    (deriv (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ))) t) *
      (textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ)))⁻¹ =
      textbookCoordinateJacobian f (Φ (t,ζ))
```

### MD-2.3.1-DeterminantODE
```json
{
  "source_id": "MD-2.3.1-DeterminantODE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "73",
  "pdf_page": "95",
  "statement_latex": "Now let $D=\\det(W)$. One can show (see Exercise 5) that\n\\[\\frac{\\dot D}{D}=\\operatorname{tr}(\\dot W W^{-1}).\\]\nThis implies that\n\\[\\dot D=\\operatorname{div}(f(\\boldsymbol z(t)))D,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A(t)=f′(z(t))，tr A=div f(z(t))；W满足上一变分ODE。原文除D的等式需D≠0，当前签名登记未除零的最终D′子句。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.determinantODE",
  "reusable_proofs": [
    "MolecularDynamics.textbookMatrixDet_hasDerivAt_of_linearODE"
  ],
  "extra_assumptions": [
    "实际W′=AW且detW≠0，符合原文W⁻¹及D除法的资格；A=f′(z(t))。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem determinantODE : ∀ n (A W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    HasDerivAt W (A t * W t) t → (W t).det ≠ 0 →
    HasDerivAt (fun s => (W s).det) ((A t).trace*(W t).det) t ∧
      deriv (fun s => (W s).det) t/(W t).det =
        Matrix.trace ((A t*W t)*(W t)⁻¹)
```

### MD-2.3.1-DeterminantExponential
```json
{
  "source_id": "MD-2.3.1-DeterminantExponential",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "73",
  "pdf_page": "95",
  "statement_latex": "and thus\n\\[D(t)=D(0)e^{\\int_0^t\\operatorname{div}(f(\\boldsymbol z(s)))\\,ds}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.determinantExponential",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际W′=AW，A连续；tr A=div f(z(s))，全实线ODE资格用于任意t积分。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem determinantExponential :
  ∀ n (A : ℝ → Matrix (Fin n) (Fin n) ℝ) (W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    Continuous A → (∀ s, HasDerivAt W (A s * W s) s) →
    (W t).det = (W 0).det * Real.exp (∫ s in (0 : ℝ)..t, (A s).trace)
```

