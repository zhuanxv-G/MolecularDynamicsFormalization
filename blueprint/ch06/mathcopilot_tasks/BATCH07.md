# BATCH07 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.1.4-PolynomialObservable
```json
{
  "source_id": "MD-6.1.4-PolynomialObservable",
  "kind": "definition",
  "label": null,
  "section": "6.1.4",
  "printed_page": "220",
  "pdf_page": "241",
  "statement_latex": "In the case of periodic boundary conditions we will assume that, for any observable of interest,\n\\[|\\phi(q,p)|=O(\\|p\\|^\\alpha),\\qquad p\\to\\infty,\\]\nfor some positive constant $\\alpha$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.polynomialObservable",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]q在实际紧torus上；用一致C(1+‖p‖)^r、C≥0及自然数r表达至多多项式增长，实α可取更大整数；不证明每个可观测量自动满足增长界。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def polynomialObservable {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C * (1 + ‖x.2‖) ^ r
```

### MD-6.1.4-CanonicalAveragePrinted
```json
{
  "source_id": "MD-6.1.4-CanonicalAveragePrinted",
  "kind": "definition",
  "label": "(6.4)",
  "section": "6.1.4",
  "printed_page": "220",
  "pdf_page": "241",
  "statement_latex": "Under assumptions on the potential energy as discussed above, and with $\\phi$ continuous and allowed to grow at most polynomially fast at infinity, we may proceed to define averages with respect to the canonical density $\\rho_\\beta$, namely\n\\[\\operatorname{Av}_\\beta(\\phi)=Z_{\\rm can}^{-1}\\int_D\\phi(q,p)\\rho_\\beta(q,p)d\\omega.\\tag{6.4}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "[ERRATUM?]式(6.3)的ρβ已含Zcan⁻¹，式(6.4)再乘一次导致Avβ(1)=Zcan⁻¹，而后文p.221使用标准归一化平均。"
    }
  ],
  "lean_decl": "MD.Ch06.canonicalAveragePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "去掉对已经归一化ρβ的第二次Zcan⁻¹；沿用未归一权重乘一次Zcan⁻¹的定义。",
      "corrected_decl": "MD.Ch06.canonicalAveragePrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def canonicalAveragePrinted {Nc : ℕ} (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ *
    ∫ z, f z * MolecularDynamics.Chapter06Review.canonicalDensity volume H β z
```

### MD-6.1.4-CanonicalAverage
```json
{
  "source_id": "MD-6.1.4-CanonicalAverage",
  "kind": "definition",
  "label": null,
  "section": "6.1.4",
  "printed_page": "220–221",
  "pdf_page": "241–242",
  "statement_latex": "We will denote the average with respect to the canonical probability density by $\\operatorname{Av}_\\beta$. Using (6.4), we can compute the average of the function $p^2$ as\n\\[\\operatorname{Av}_\\beta(p^2)=\\int_{-\\infty}^{\\infty}\\int_{-\\infty}^{\\infty}p^2\\rho_\\beta dqdp.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际未归一权重的积分乘真实partition倒数；定义不计可积性或归一化已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.canonicalAverage",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA][ERRATUM?]按p.221的实际用法与概率平均标准定义去掉式(6.4)对已归一ρ的第二次Z⁻¹；原字面版仍保留NEEDS_HUMAN。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def canonicalAverage {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z

/-- 修正版，对应原文 MD-6.1.4-CanonicalAveragePrinted；改动：去掉对已经归一化ρβ的第二次Zcan⁻¹；沿用未归一权重乘一次Zcan⁻¹的定义。 -/
noncomputable def canonicalAveragePrinted_corrected {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z
```

### MD-6.1.4-CanonicalAverageOne
```json
{
  "source_id": "MD-6.1.4-CanonicalAverageOne",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.4",
  "printed_page": "218–220",
  "pdf_page": "239–241",
  "statement_latex": "The quantity $Z_{\\rm can}$ is a normalizing constant so that this is a probability density.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.canonicalAverageOne",
  "reusable_proofs": [
    "MolecularDynamics.textbookCanonicalAverage_one"
  ],
  "extra_assumptions": [
    "[EXTRA]标准归一化概率平均的实际检验Avβ(1)=1；保留旧CH06-017，独立于错误的式(6.4)重复归一化字面定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem canonicalAverageOne {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (hρ : Integrable (textbookHamiltonianGibbsWeight H β)) :
    textbookCanonicalAverage H β (fun _ ↦ 1) = 1
```

