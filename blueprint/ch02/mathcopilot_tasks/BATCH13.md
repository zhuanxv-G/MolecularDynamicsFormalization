# BATCH13 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.3.1-FlowDet
```json
{
  "source_id": "MD-2.3.1-FlowDet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "73",
  "pdf_page": "95",
  "statement_latex": "In particular, if $\\operatorname{div}f\\equiv0$, we see that $D\\equiv D(0)=1$ and it follows that the volume is constant. Liouville’s theorem may be summarized compactly as:\n\\[\\nabla\\cdot f=0\\Rightarrow\\det\\mathcal F_t'=1.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.flowDet",
  "reusable_proofs": [
    "MolecularDynamics.textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]Φ联合C²、f C¹、Φ0=id，τ>0及实际ODE；D0=1由Jacobian初值而非结论假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem flowDet
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, ∀ z, (textbookCoordinateJacobian (fun y => Φ (t, y)) z).det = 1
```

### MD-2.3.1-LJOscillator
```json
{
  "source_id": "MD-2.3.1-LJOscillator",
  "kind": "definition",
  "label": "Example 2.3 (model)",
  "section": "2.3.1",
  "printed_page": "73–74",
  "pdf_page": "95–96",
  "statement_latex": "A 1-d oscillator with Lennard-Jones potential is described by the equations\n\\[\\dot q=p,\\qquad\\dot p=-\\varphi_{LJ}'(q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "φ=第1章Lennard–Jones势，q>0物理位置域；仅定义实际ODE关系。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.ljOscillatorEquation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def ljOscillatorEquation (φ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ ((γ t).2,-deriv φ (γ t).1) t
```

### MD-2.3.1-LJBoundedPeriodic
```json
{
  "source_id": "MD-2.3.1-LJBoundedPeriodic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "74",
  "pdf_page": "96",
  "statement_latex": "As a consequence of energy conservation, any bounded individual trajectory of this system will be a periodic orbit.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.ljBoundedPeriodic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "LJ参数正，实际全时轨迹且位置q>0；平衡解也允许任意正周期。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem ljBoundedPeriodic : ∀ (σ ε : ℝ) (γ : ℝ → ℝ × ℝ),
    0 < σ → 0 < ε →
    ljOscillatorEquation (fun q => 4*ε*((σ/q)^12-(σ/q)^6)) γ Set.univ →
    (∀ t, 0 < (γ t).1) → Bornology.IsBounded (Set.range γ) →
    ∃ T > 0, ∀ t, γ (t+T) = γ t
```

