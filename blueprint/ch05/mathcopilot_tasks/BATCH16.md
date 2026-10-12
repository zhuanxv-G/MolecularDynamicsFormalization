# BATCH16 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.3.3-MicroMeasure
```json
{
  "source_id": "MD-5.3.3-MicroMeasure",
  "kind": "definition",
  "label": null,
  "section": "5.3.3",
  "printed_page": "194",
  "pdf_page": "215",
  "statement_latex": "Let $d\\mu_E=Z_E^{-1}\\|\\nabla H\\|^{-1}d\\sigma$. We refer to this as the microcanonical probability density and write, for an “appropriate” set $A$, $\\operatorname{Pr}(A)=\\mu_E(A)=\\int_A d\\mu_E$. The only requirement for this to make sense is that the set $A$ be a measurable subset of the $H=E$ energy surface, i.e. that it be possible to compute its surface area.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.microMeasure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]总raw质量正且有限是使用概率意义的必要资格；定义用实际ENNReal标量归一化，不把无穷总质量逆值0解释成概率测度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def microMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c
```

### MD-5.3.3-MicroProbability
```json
{
  "source_id": "MD-5.3.3-MicroProbability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.3",
  "printed_page": "195",
  "pdf_page": "216",
  "statement_latex": "We have the standard properties of a probability function: $0\\leq\\operatorname{Pr}(A)\\leq1$ for all measurable sets $A$; $\\operatorname{Pr}(\\Sigma_E)=1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.microProbability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原H光滑背景及正有限总质量明示；ΣE总概率1也保留，不仅证明ambient univ质量1。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem microProbability : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 1 H → 0 < (MolecularDynamics.Chapter05Review.microRaw H c) univ → (MolecularDynamics.Chapter05Review.microRaw H c) univ < (⊤ : ENNReal) →
  (MolecularDynamics.Chapter05Review.microMeasure H c) univ=1 ∧
    (MolecularDynamics.Chapter05Review.microMeasure H c) (MolecularDynamics.Chapter05Review.energySurface H c)=1 ∧
    ∀ A : Set (MolecularDynamics.Chapter05Review.E n),0 ≤ (MolecularDynamics.Chapter05Review.microMeasure H c) A ∧ (MolecularDynamics.Chapter05Review.microMeasure H c) A ≤ 1
```

### MD-5.3.3-LowerDimensionNull
```json
{
  "source_id": "MD-5.3.3-LowerDimensionNull",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.3",
  "printed_page": "195",
  "pdf_page": "216",
  "statement_latex": "We also note that lower order objects such as a point or a curve in $\\mathbb R^2$, or a surface in $\\mathbb R^3$, have zero measure with respect to Lebesgue measure for the ambient space. Similarly, for a Hamiltonian system with $N_d$ degrees of freedom, the energy surface is of dimension $2N_d-1$ and the probability measure of sets of lower dimension than this will vanish.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.lowerDimensionNull",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]低维光滑参数化的紧像、正则C¹能量面，维数严格小于能量面；未将任意“拓扑低维集合”自动视为零测。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lowerDimensionNull :
  ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : Set (MolecularDynamics.Chapter05Review.E d)), d+1 < n → ContDiff ℝ 1 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
    ContDiff ℝ 1 g → IsCompact K →
    g '' K ⊆ MolecularDynamics.Chapter05Review.energySurface H c → (MolecularDynamics.Chapter05Review.microMeasure H c) (g '' K)=0
```

### MD-5.3.3-MicroAverage
```json
{
  "source_id": "MD-5.3.3-MicroAverage",
  "kind": "definition",
  "label": null,
  "section": "5.3.3",
  "printed_page": "195",
  "pdf_page": "216",
  "statement_latex": "As we mentioned in motivating the microcanonical distribution, we could alternatively view microcanonical averages as integrals with respect to the singular measure on the ambient space $D$ defined by $\\mu_Ed\\omega'=Z_E^{-1}\\delta[H-E]d\\omega$. Regardless of which formulation is adopted, we may use the probability measure to compute expectations (averages) of (suitable) functions defined on the phase space. We write such an expectation as\n\\[\\operatorname{Av}_{H=E}(g)=\\int_{\\Sigma_E}g(z)d\\mu_E=\\int_Dg(z)\\mu_Ed\\omega'.\\]\nAs shorthand, where the underlying space and probability density are assumed, one may write such an average more simply as $\\operatorname{Av}_{H=E}(g)=\\langle g\\rangle$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际归一化奇异测度上的积分；δ[H−E]是分布记号，面积/δ两描述的识别是未证明的coarea义务，不称普通Lebesgue密度。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.microAverage",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def microAverage {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) := MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.microMeasure H c) g
```

