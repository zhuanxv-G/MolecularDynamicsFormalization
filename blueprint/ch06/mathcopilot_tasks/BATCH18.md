# BATCH18 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3.1-ScalarItoFormula
```json
{
  "source_id": "MD-6.3.1-ScalarItoFormula",
  "kind": "unnumbered_claim",
  "label": "(6.17)",
  "section": "6.3.1",
  "printed_page": "233",
  "pdf_page": "254",
  "statement_latex": "Let $\\phi(x)$ be any continuously twice differentiable function and let $X_n\\in\\mathbb R$ represent the state of a biased random walk as considered in Sect. 6.3, i.e., with state $X_{n+1}=X_n+a(X_n,n\\delta t)\\delta t+b(X_n,n\\delta t)J_n\\delta x$.\n\\[d\\phi(X)=\\phi'(X)(a(X,t)dt+b(X,t)dW)+\\tfrac12\\phi''(X)b(X,t)^2dt.\\tag{6.17}\\]",
  "proof_latex": "Let $\\phi_n=\\phi(X_n)$, then Taylor's theorem gives\n\\[\\delta\\phi\\stackrel{\\rm def}=\\phi_{n+1}-\\phi_n=\\phi'(X_n)\\delta X_n+\\tfrac12\\phi''(X_n)\\delta X_n^2+o(\\delta X_n^2)\n=\\phi'(X_n)(a(X_n,n\\delta t)\\delta t+b(X_n,n\\delta t)J_n\\delta x)\n+\\tfrac12\\phi''(X_n)(a(X_n,n\\delta t)\\delta t+b(X_n,n\\delta t)J_n\\delta x)^2+o(\\delta X_n^2).\\]\nNow we expand the 2nd order term and, working in the diffusion limit, recognize that $\\delta x^2\\approx\\delta t$, thus we have\n\\[\\delta\\phi=\\phi'(X_n)(a(X_n,n\\delta t)\\delta t+b(X_n,n\\delta t)J_n\\delta x)+\\tfrac12\\phi''(X_n)b(X_n,n\\delta t)^2\\delta t+O(\\delta t^{3/2}).\\]\nPassing to the limit, this leads to the SDE.",
  "proof_note": "原启发证明完整保留；C²仅给o(δt)，O(δt³⁄²)需要更高阶资格，另条疑误。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.scalarItoFormula",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原C²φ、真实PreBrownian和严格积分方程；完整漂移、噪声、二阶Ito校正；适应/可积技术资格保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem scalarItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 2 φ → ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) T
    (fun sample ↦ φ (X T sample)-φ x0 - ∫ s in 0..T,
      deriv φ (X s sample)*a (X s sample) s + deriv (deriv φ) (X s sample)*b (X s sample) s^2/2)
```

### MD-6.3.1-DiffusiveTaylorPrinted
```json
{
  "source_id": "MD-6.3.1-DiffusiveTaylorPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.1",
  "printed_page": "233",
  "pdf_page": "254",
  "statement_latex": "Now we expand the 2nd order term and, working in the diffusion limit, recognize that $\\delta x^2\\approx\\delta t$, thus we have\n\\[\\delta\\phi=\\phi'(X_n)(a(X_n,n\\delta t)\\delta t+b(X_n,n\\delta t)J_n\\delta x)+\\tfrac12\\phi''(X_n)b(X_n,n\\delta t)^2\\delta t+O(\\delta t^{3/2}).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "C² Taylor余项仅o(h²)，不能自动提升为O(h³)；在h≈√δt时原O(δt³⁄²)需要更高阶正则性。"
    }
  ],
  "lean_decl": "MD.Ch06.diffusiveTaylorPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem diffusiveTaylorPrinted : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 2 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ))
```

### MD-6.3.1-TimeItoFormula
```json
{
  "source_id": "MD-6.3.1-TimeItoFormula",
  "kind": "unnumbered_claim",
  "label": "(6.18)",
  "section": "6.3.1",
  "printed_page": "234",
  "pdf_page": "255",
  "statement_latex": "We also mention that the Itô-Doeblin formula can be easily generalized to functions of the form $\\phi(x,t)$:\n\\[d\\phi(X,t)=\\phi_t(X,t)+\\phi_x(X,t)(a(X,t)dt+b(X,t)dW)+\\tfrac12\\phi_{xx}(X,t)b(X,t)^2dt.\\tag{6.18}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "印刷φ_t(X,t)项漏dt，字面微分式不具一致类型；补dt需要网站审计裁定。"
    }
  ],
  "lean_decl": "MD.Ch06.timeItoFormula",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Lean保留完整积分陈述，以φ_t dt的正确时间积分表达；原无dt的字面式仍在逐字JSON，不宣称字面式已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem timeItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 → ContDiff ℝ 2 φ →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2)
```

