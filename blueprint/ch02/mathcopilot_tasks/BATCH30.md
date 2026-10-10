# BATCH30 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.5.3-Newmark
```json
{
  "source_id": "MD-2.5.3-Newmark",
  "kind": "definition",
  "label": null,
  "section": "2.5.3",
  "printed_page": "92",
  "pdf_page": "114",
  "statement_latex": "As a special case of a partitioned Runge-Kutta method, consider the Newmark family of methods [280] defined for two parameters $\\sigma$ and $\\eta$ by the formulas\n\\[\\boldsymbol P=\\boldsymbol p-h(1-\\sigma)\\nabla U(\\boldsymbol q)-h\\sigma\\nabla U(\\boldsymbol Q),\\]\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol p-h^2\\left(\\frac12-\\eta\\right)\\nabla U(\\boldsymbol q)-h^2\\eta\\nabla U(\\boldsymbol Q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Lean γ/β分别原文σ/η，F=-∇U；严格保留Q式两个force项缺M⁻¹。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "Q式力项缺M⁻¹；不默改成质量一致Newmark。"
    }
  ],
  "lean_decl": "MD.Ch02.bp_newmarkRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_newmarkRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (γ β h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 + (h*(1-γ)) • F z.1 + (h*γ) • F w.1 ∧
  w.1 = z.1 + h • invMass m z.2 + (h^2*(1/2-β)) • F z.1 + (h^2*β) • F w.1
```

### MD-2.5.3-NewmarkReduction
```json
{
  "source_id": "MD-2.5.3-NewmarkReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.3",
  "printed_page": "92",
  "pdf_page": "114",
  "statement_latex": "For $\\eta=0$ we then arrive at the Verlet method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "“then”前句σ=1/2；保留一般M的字面全称。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "字面Newmark在一般M不等于Verlet，仅M=I或修正Q式force质量因子后成立；不以旧质量修正版证明替代原句。"
    }
  ],
  "lean_decl": "MD.Ch02.newmarkReduction",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem newmarkReduction : ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h z w,
    newmarkRelation m F (1/2) 0 h z w ↔ w=verlet m F h z
```

### MD-2.5.3-NewmarkDamping
```json
{
  "source_id": "MD-2.5.3-NewmarkDamping",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.3",
  "printed_page": "92",
  "pdf_page": "114",
  "statement_latex": "In practice the choice $\\sigma=1/2$ is used to avoid spurious damping (it can be demonstrated for a simple model problem); this certainly would appear to be desirable in the setting of molecular dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.newmarkDamping",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]限定原文simple model为单位质量线性振子；h步隐式线性系统非奇异；用实际放大矩阵det=1表达无面积收缩，不声称任意势能能量恒定。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem newmarkDamping :
  ∀ (G : Q 2 → Q 2) Ω β h,
    ContDiff ℝ 1 G → (∀ z,
      G z 1 = z 1-h/2*Ω^2*(z 0+G z 0) ∧
      G z 0 = z 0+h*z 1-h^2*((1/2-β)*Ω^2*z 0+β*Ω^2*G z 0)) →
    1+h^2*β*Ω^2 ≠ 0 → ∀ z, (textbookCoordinateJacobian G z).det = 1
```

### MD-2.5.3-NewmarkNotSymplectic
```json
{
  "source_id": "MD-2.5.3-NewmarkNotSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.3",
  "printed_page": "92",
  "pdf_page": "114",
  "statement_latex": "The implicit Newmark methods are not symplectic, but a related family of symplectic methods can be constructed by using linear interpolated forces evaluated at interpolated positions [395].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.newmarkNotSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]存在一个非线性势能、β≠0与非零步长的实际可微求解反例；不是排除每个线性特殊情形。单位质量与字面式一致。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem newmarkNotSymplectic :
  ∃ (U : Q 1 → ℝ) (β h : ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1),
    ContDiff ℝ 3 U ∧ β ≠ 0 ∧ h ≠ 0 ∧ ContDiff ℝ 1 G ∧
    (∀ z, newmarkMassCorrected (fun _ => 1) (textbookPotentialForce U) (1/2) β h
      (unpack z) (unpack (G z))) ∧ ¬ IsTextbookSymplecticMap G
```

