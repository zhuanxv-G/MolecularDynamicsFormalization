# BATCH41 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.4-FredholmAlternative
```json
{
  "source_id": "MD-6.4.4-FredholmAlternative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "257",
  "pdf_page": "278",
  "statement_latex": "The Fredholm Alternative says that, for a linear operator $A$ with compact resolvent, we have one of the following two conditions:\n• $A\\varphi=g$ has a solution.\n• There is a function $y$ with $A^*y=0$ and $\\langle y,g\\rangle\\ne0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.fredholmAlternative",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际稠密域闭Hilbert partialoperator图、actual adjoint以及shift1的完整紧resolvent（含逆的存在/唯一）；全部g可解当且仅当adjoint kernel正交，没有假设目标可解性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem fredholmAlternative :
  ∀ {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [CompleteSpace E] (A : E →ₗ.[ℝ] E), Dense (A.domain : Set E) → IsClosed (A.graph : Set (E × E)) →
  (∃ R : E →L[ℝ] E, IsCompactOperator R ∧
    (∀ x, (R x, R x-x) ∈ A.graph) ∧
    ∀ x y, (y,y-x) ∈ A.graph → y=R x) →
  ∀ g : E, (∃ φ : E, (φ,g) ∈ A.graph) ↔ ∀ y : E, (y,0) ∈ A.adjoint.graph → ⟪y,g⟫_ℝ=0
```

### MD-6.4.4-BackwardKernelConstants
```json
{
  "source_id": "MD-6.4.4-BackwardKernelConstants",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "257",
  "pdf_page": "278",
  "statement_latex": "In our case, $A=\\mathcal L_{LD}^*$. The only solutions of $\\mathcal L_{LD}y=0$ (conserved quantities of Langevin dynamics) are the constants.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.backwardKernelConstants",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实Gibbs加权Lp²闭backward operator图的全部粗域元素；不能用已证C0固定观测量特例替代。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem backwardKernelConstants :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ),
    (f,0) ∈ (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).graph →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ, f x=c
```

### MD-6.4.4-ForwardKernelGibbs
```json
{
  "source_id": "MD-6.4.4-ForwardKernelGibbs",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "257",
  "pdf_page": "278",
  "statement_latex": "If we have two solutions $\\varphi_1,\\varphi_2$ of $\\mathcal L_{LD}^*\\varphi=g$, then their difference $w$ must be a solution of $\\mathcal L_{LD}^*w=0$ and the only such solution is a constant multiple of the Gibbs density $\\rho_\\beta$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.forwardKernelGibbs",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整原flat forward弱PDE与真实H1类，全部stationary modes为Gibbs倍数；相对加权adjoint kernel对应常数而非Gibbs，不能混同二者。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem forwardKernelGibbs : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ) (hβ : 0 < β),
  0 < γ → ∀ w : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    MolecularDynamics.Chapter06Review.flatForwardWeak U β γ
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ w) 0 →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
      textbookLangevinCanonicalWeakH1Value U hU hp β hβ w x=c*textbookLangevinCanonicalDensity U β x
```

### MD-6.4.4-WeightedFunctionNorm
```json
{
  "source_id": "MD-6.4.4-WeightedFunctionNorm",
  "kind": "definition",
  "label": null,
  "section": "6.4.4",
  "printed_page": "256",
  "pdf_page": "277",
  "statement_latex": "\\[\\|f\\|_{L^2(\\mu)}^2=\\int_D f^2\\mu(d\\omega).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.weightedFunctionNorm",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Lp² AE类范数；Mathlib的eLpNorm定义为真实二阶积分，不把任意非可积函数的默认Bochner积分当范数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def weightedFunctionNorm {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ‖f‖^2
```

### MD-6.4.4-WeightedVectorNorm
```json
{
  "source_id": "MD-6.4.4-WeightedVectorNorm",
  "kind": "definition",
  "label": null,
  "section": "6.4.4",
  "printed_page": "257",
  "pdf_page": "278",
  "statement_latex": "For a vector function $w:D\\to\\mathbb R^{N_c}$, we have\n\\[\\|w\\|_{L^2(\\mu)}^2=\\sum_{i=1}^{N_c}\\|w_i\\|_{L^2(\\mu)}^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.weightedVectorNorm",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整任意维度的所有真实L²分量，弱导数族使用同一实际Gibbs测度；不遗漏向量范数定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def weightedVectorNorm {n r : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (w : Fin r → Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ∑ i, ‖w i‖^2
```

