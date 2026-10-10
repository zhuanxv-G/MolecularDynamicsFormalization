# BATCH26 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.4.5-Conjugacy
```json
{
  "source_id": "MD-2.4.5-Conjugacy",
  "kind": "definition",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "In general, we say that two maps $A$ and $B$ are conjugate if there is a homeomorphism $\\chi$ such that\n\\[A=\\chi^{-1}\\circ B\\circ\\chi.\\]\nA homeomorphism is a continuous bijection which has a continuous inverse.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "χ为实际Homeomorph，包含正逆连续与双逆律。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_conjugateMap",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_conjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ
```

### MD-2.4.5-ConjugateIterates
```json
{
  "source_id": "MD-2.4.5-ConjugateIterates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "Conjugate maps have the property that their iterates are also conjugate, since\n\\[A^n=(\\chi^{-1}\\circ B\\circ\\chi)^n=(\\chi^{-1}\\circ B\\circ\\chi)\\circ(\\chi^{-1}\\circ B\\circ\\chi)\\circ\\cdots\\circ(\\chi^{-1}\\circ B\\circ\\chi)=\\chi^{-1}B^n\\circ\\chi.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.conjugateIterates",
  "reusable_proofs": [
    "MolecularDynamics.textbook_conjugate_iterates"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem conjugateIterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n])
```

### MD-2.4.5-ConjugateLimits
```json
{
  "source_id": "MD-2.4.5-ConjugateLimits",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "If $A$ and $B$ are maps of phase space, then the conjugacy implies that they have equivalent stability properties under iteration, since if $B^n(\\boldsymbol z_0)\\to\\boldsymbol z^*$, as $n\\to\\infty$, for all initial points $\\boldsymbol z_0$, then also $A^n(\\boldsymbol z_0)\\to\\chi^{-1}(\\boldsymbol z^*)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.conjugateLimits",
  "reusable_proofs": [
    "MolecularDynamics.textbook_conjugate_iterates_tendsto_iff"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem conjugateLimits (χ : E ≃ₜ E) (A B : E → E) (hA : A=textbookConjugateMap χ B)
    (zStar : E) (hB : ∀ z, Tendsto (fun k : ℕ => B^[k] z) atTop (𝓝 zStar)) :
    ∀ z, Tendsto (fun k : ℕ => A^[k] z) atTop (𝓝 (χ.symm zStar))
```

### MD-2.4.5-EulerConjugacy
```json
{
  "source_id": "MD-2.4.5-EulerConjugacy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "As an illustration, the Symplectic Euler method turns out to be conjugate to the Verlet method (see Exercise 12).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "χh为半步momentum kick，反向kick是确实逆；有效二阶还依赖Verlet全局二阶，另列缺项。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.eulerConjugacy",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem eulerConjugacy :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ textbookSymplecticEuler m U h ∘
      textbookMomentumKick (textbookPotentialForce U) (-h/2) = coordinateVerlet m (textbookPotentialForce U) h
```

### MD-2.4.5-Processing
```json
{
  "source_id": "MD-2.4.5-Processing",
  "kind": "definition",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "Let us suppose that we have such a conjugacy between two numerical methods $\\mathcal G_h$ and $\\tilde{\\mathcal G}_h$, that is\n\\[\\mathcal G_h=\\chi_h^{-1}\\circ\\tilde{\\mathcal G}_h\\circ\\chi_h,\\]\ndefined in such a way that $\\mathcal G_h$ has order $r$ and $\\tilde{\\mathcal G}_h$ has order $s<r$. Then, given an initial condition $\\boldsymbol z_0$, we first modify (“pre-process”) this to $\\tilde{\\boldsymbol z}_0=\\chi_h(\\boldsymbol z_0)$, then take multiple steps with the method $\\tilde{\\mathcal G}_h$, and finally transform (“post-process”) each obtained point back by $\\chi_h^{-1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "G及χ给定真实共轭，定阶r/s是该算法外部资格；定义保存pre/iterate/post全过程。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_processedIterate",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def bp_processedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)
```

### MD-2.4.5-ProcessingIterates
```json
{
  "source_id": "MD-2.4.5-ProcessingIterates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "The resulting approximation will be of order $r$ even though the timestepping is performed using a lower order method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "先给出处理算法与高阶方法真实迭代相等；最大误差及阶结论下一项，不以共轭凭空推出r阶。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.processingIterates",
  "reusable_proofs": [
    "MolecularDynamics.textbookProcessedIterate_eq_of_conjugacy"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem processingIterates (χ : ℝ → E ≃ₜ E)
    (B G : ℝ → E → E) (hG : ∀ h, G h = textbookProcessedMethod χ B h)
    (h : ℝ) (z₀ : E) (n : ℕ) :
    textbookProcessedIterate χ B h z₀ n = oneStepIterate G h z₀ n
```

### MD-2.4.5-ProcessingOrder
```json
{
  "source_id": "MD-2.4.5-ProcessingOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "The resulting approximation will be of order $r$ even though the timestepping is performed using a lower order method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文明示G已具有r阶；这是对不同算法迭代的精确误差转移，不把待证processed误差作假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.processingOrder",
  "reusable_proofs": [
    "MolecularDynamics.textbookProcessedMaxError_eq_of_conjugacy"
  ],
  "extra_assumptions": [
    "r自然数有限时间窗误差界；χh为实际Homeomorph。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem processingOrder (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (hG : ∀ h, G h=textbookProcessedMethod χ B h) (γ : ℝ → E) (τ : ℝ) (r : ℕ)
    (horder : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError G (τ/ν) γ ν ≤ C*(τ/ν)^r) :
    (∀ h ν, textbookProcessedMaxError χ B h γ ν=oneStepMaxError G h γ ν) ∧
    (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      textbookProcessedMaxError χ B (τ/ν) γ ν ≤ C*(τ/ν)^r)
```

### MD-2.4.5-EulerEffectiveOrder
```json
{
  "source_id": "MD-2.4.5-EulerEffectiveOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "One sometimes refers to the “effective order” of a numerical method as the order attainable via processing, thus the effective order of the Symplectic Euler method would be two.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.eulerEffectiveOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正固定质量，U C⁴；真实机械Hamilton轨迹及紧时间窗；处理器为实际Homeomorph，完整processed误差界，不以待证二阶作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem eulerEffectiveOrder : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) τ,
    positiveMass m → ContDiff ℝ 4 U → 0 < τ →
    (∀ t ∈ Icc 0 τ, HasDerivWithinAt γ
      (textbookHamiltonianVectorField (fun z => (∑ i, z (Sum.inr i)^2/m i)/2+
        U (z ∘ Sum.inl)) (γ t)) (Icc 0 τ) t) → ContinuousOn γ (Icc 0 τ) →
    ∃ χ : ℝ → SymplecticCoordinates n ≃ₜ SymplecticCoordinates n,
      (∀ h, textbookProcessedMethod χ (textbookSymplecticEuler m U) h =
        coordinateVerlet m (textbookPotentialForce U) h) ∧
      (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        textbookProcessedMaxError χ (textbookSymplecticEuler m U) (τ/ν) γ ν ≤ C*(τ/ν)^2)
```

