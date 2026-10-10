# BATCH17 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.6-HamiltonianFlowStructures
```json
{
  "source_id": "MD-3.6-HamiltonianFlowStructures",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6",
  "printed_page": "127–128",
  "pdf_page": "149–150",
  "statement_latex": "The flow of a Hamiltonian system of the form $H=p^TM^{-1}p/2+U(q)$ will preserve all of the following:\n1. The symplectic two-form $\\mathrm dq\\wedge\\mathrm dp$.\n2. The Hamiltonian (i.e., the energy) $H$.\n3. The volume in phase space (as the vector field is divergence free).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原列表第4项time-reversal symmetry由§3.6.1–2单独保留；此签名保留一般C¹局部流的前三性质，不能由较强jointC²桥接冒充。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianFlowStructures",
  "reusable_proofs": [],
  "extra_assumptions": [
    "原场在开放域C¹，真实局部流、反步与局部定义域资格显式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianFlowStructures :
  ∀ n (H : SymplecticCoordinates n → ℝ) D Ω
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    0 < τ → ContDiffOn ℝ 2 H D → localFlowC1 (textbookHamiltonianVectorField H) D Ω Φ τ →
    (∀ t ∈ Ioo 0 τ, ∀ z ∈ Ω,
      HasDerivAt (fun s => textbookJacobian (fun y => Φ (s,y)) z)
        (textbookJ n*textbookHamiltonianHessian H (Φ (t,z))*textbookJacobian (fun y => Φ (t,y)) z) t) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, IsTextbookSymplectic (textbookJacobian (fun y => Φ (t,y)) z)) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, (textbookJacobian (fun y => Φ (t,y)) z).det = 1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → S ⊆ Ω →
      volume ((fun z => Φ (t,z)) '' S) = volume S)
```

### MD-3.6-VolumeNotSymplectic
```json
{
  "source_id": "MD-3.6-VolumeNotSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6",
  "printed_page": "128",
  "pdf_page": "150",
  "statement_latex": "The phase volume conservation can be seen as a consequence of the symplectic property, but it is a weaker condition. It is possible to construct methods that preserve volume but which are not symplectic, and we can build methods that exactly conserve the energy (as we shall show below).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "四维实际光滑映射、Jacobian det=1且不辛；辛蕴含体积见第2章，能量投影见§3.5。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.volumeNotSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem volumeNotSymplectic :
  ∃ G : SymplecticCoordinates 2 → SymplecticCoordinates 2,
    ContDiff ℝ 1 G ∧ (∀ z, (textbookJacobian G z).det=1) ∧ ¬ IsTextbookSymplecticMap G
```

