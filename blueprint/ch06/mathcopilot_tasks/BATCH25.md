# BATCH25 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3.6-PolynomialSmooth
```json
{
  "source_id": "MD-6.3.6-PolynomialSmooth",
  "kind": "definition",
  "label": null,
  "section": "6.3.6",
  "printed_page": "241",
  "pdf_page": "262",
  "statement_latex": "This condition of polynomial growth of the coefficients is a common assumption in the analysis of SDEs. For future purposes we define the space of functions which are $C^\\infty$ smooth and satisfy the polynomial growth restriction by $C_P^\\infty$:\n\\[C_P^\\infty\\stackrel{\\mathrm{def}}=\\{\\phi\\in C^\\infty\\mid\\exists r\\in\\mathbb N:\\phi(x)=O(|x|^r),\\ x\\to\\pm\\infty\\}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实函数值的多项式增长；不擅自增加所有阶导数也有多项式增长。全域(1+|x|)^r界等价于尾部O加连续紧集界。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.polynomialSmooth",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-16",
      "action": "original_page_recheck",
      "reason": "按原PDF逐字恢复引文，原草稿的For future reference不在原页。",
      "evidence": "source_pages/p262.png; source_pages/p263.png; visual check 2026-10-16",
      "before": {
        "statement_latex": "For future reference we define the space of functions which are $C^\\infty$ smooth and satisfy the polynomial growth restriction by $C_P^\\infty$:\n\\[C_P^\\infty=\\{\\phi\\in C^\\infty\\mid\\exists r\\in\\mathbb N:\\phi(x)=O(|x|^r),\\ x\\to\\pm\\infty\\}.\\]"
      },
      "after": {
        "statement_latex": "This condition of polynomial growth of the coefficients is a common assumption in the analysis of SDEs. For future purposes we define the space of functions which are $C^\\infty$ smooth and satisfy the polynomial growth restriction by $C_P^\\infty$:\n\\[C_P^\\infty\\stackrel{\\mathrm{def}}=\\{\\phi\\in C^\\infty\\mid\\exists r\\in\\mathbb N:\\phi(x)=O(|x|^r),\\ x\\to\\pm\\infty\\}.\\]"
      },
      "website": "待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def polynomialSmooth (f : ℝ → ℝ) : Prop :=
  ContDiff ℝ ∞ f ∧ ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C*(1+|x|)^r
```

### MD-6.3.6-DensityExpectation
```json
{
  "source_id": "MD-6.3.6-DensityExpectation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.6",
  "printed_page": "241",
  "pdf_page": "262",
  "statement_latex": "For any $\\phi\\in C_P^\\infty$, the expectation with respect to $\\rho(x,t)$ is well defined and we have\n\\[\\mathbb E\\phi(X(t))=\\langle\\phi,\\rho\\rangle=\\int_{-\\infty}^{+\\infty}\\phi(x)\\rho(x,t)dx.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.densityExpectation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实非负可测density与全局指数尾界；完整可积与积分law等式，不预置这些结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem densityExpectation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (X : Ω → ℝ) (ρ φ : ℝ → ℝ),
  HasLaw X (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) P →
  (∀ x, 0 ≤ ρ x) → Measurable ρ → MolecularDynamics.Chapter06Review.polynomialSmooth φ →
  (∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x, ρ x ≤ C*Real.exp (-c*|x|)) →
  Integrable (fun sample ↦ φ (X sample)) P ∧
    (∫ sample, φ (X sample) ∂P)=(∫ x, φ x*ρ x)
```

### MD-6.3.6-ScalarForward
```json
{
  "source_id": "MD-6.3.6-ScalarForward",
  "kind": "definition",
  "label": null,
  "section": "6.3.6",
  "printed_page": "242",
  "pdf_page": "263",
  "statement_latex": "In the case at hand the adjoint is\n\\[\\mathcal L^*\\rho=-(a(x)\\rho)_x+\\tfrac12(b^2(x)\\rho)_{xx},\\]\nwhich we shall refer to as the Kolmogorov operator.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整正号diffusion伴随算子；PDE从law推导另条，不计定义已证PDE。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.scalarForward",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-16",
      "action": "original_page_recheck",
      "reason": "原页无编号；(6.39)属于后页多维SDE，不是此标量伴随算子。",
      "evidence": "source_pages/p262.png; source_pages/p263.png; visual check 2026-10-16",
      "before": {
        "label": "(6.39)",
        "statement_latex": "As this holds for any function $\\phi$ in the appropriate space, we may obtain an equation for the time evolution of $\\rho$:\n\\[\\frac{\\partial\\rho}{\\partial t}=-\\frac\\partial{\\partial x}(a(x)\\rho)+\\frac12\\frac{\\partial^2}{\\partial x^2}(b^2(x)\\rho).\\tag{6.39}\\]"
      },
      "after": {
        "label": null,
        "statement_latex": "In the case at hand the adjoint is\n\\[\\mathcal L^*\\rho=-(a(x)\\rho)_x+\\tfrac12(b^2(x)\\rho)_{xx},\\]\nwhich we shall refer to as the Kolmogorov operator."
      },
      "website": "待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def scalarForward (a b ρ : ℝ → ℝ) (x : ℝ) : ℝ :=
  -deriv (fun z ↦ a z*ρ z) x + deriv (deriv (fun z ↦ b z^2*ρ z)) x/2
```

### MD-6.3.6-FPDriftAdjoint
```json
{
  "source_id": "MD-6.3.6-FPDriftAdjoint",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.6",
  "printed_page": "241–242",
  "pdf_page": "262–263",
  "statement_latex": "First, we find\n\\[\\int_{-\\infty}^{+\\infty}a(x)\\phi'(x)\\rho(x,t)dx=[\\phi(x)a(x)\\rho(x,t)]_{-\\infty}^{+\\infty}-\\int_{-\\infty}^{+\\infty}\\phi(x)(a(x)\\rho(x,t))_x dx\n=-\\int_{-\\infty}^{+\\infty}\\phi(x)(a(x)\\rho(x,t))_x dx.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.fpDriftAdjoint",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]当前完整紧支撑C¹检验桥接；原指数尾和多项式检验的全域版本在FPPolynomialAdjoint保留，不将紧支撑特例计为原全部检验已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem fpDriftAdjoint :
  ∀ (a ρ φ : ℝ → ℝ),
  ContDiff ℝ 1 a → ContDiff ℝ 1 ρ → ContDiff ℝ 1 φ →
  HasCompactSupport φ → (∫ x, a x*deriv φ x*ρ x) = ∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x)
```

### MD-6.3.6-FPDiffusionPrinted
```json
{
  "source_id": "MD-6.3.6-FPDiffusionPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.6",
  "printed_page": "242",
  "pdf_page": "263",
  "statement_latex": "With two rounds of integration by parts on the term involving $b(x)$, we find, using the fact that the boundary terms vanish,\n\\[\\int_{-\\infty}^{+\\infty}b^2(x)\\phi''(x)\\rho(x,t)dx=-\\int_{-\\infty}^{+\\infty}\\phi(x)(b^2(x)\\rho)_{xx}dx.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原页两次IBP后仍打印负号；正确应正号，且(6.39)最终算子已经使用正号。"
    }
  ],
  "lean_decl": "MD.Ch06.fpDiffusionPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-16",
      "action": "original_page_recheck",
      "reason": "保留原书错误负号；恢复原页引导句，不用转述替代原引文。",
      "evidence": "source_pages/p262.png; source_pages/p263.png; visual check 2026-10-16",
      "before": {
        "statement_latex": "Using two integrations by parts gives\n\\[\\int_{-\\infty}^{+\\infty}b^2(x)\\phi''(x)\\rho(x,t)dx=-\\int_{-\\infty}^{+\\infty}\\phi(x)(b^2(x)\\rho(x,t))_{xx}dx.\\]"
      },
      "after": {
        "statement_latex": "With two rounds of integration by parts on the term involving $b(x)$, we find, using the fact that the boundary terms vanish,\n\\[\\int_{-\\infty}^{+\\infty}b^2(x)\\phi''(x)\\rho(x,t)dx=-\\int_{-\\infty}^{+\\infty}\\phi(x)(b^2(x)\\rho)_{xx}dx.\\]"
      },
      "website": "待网站审计"
    },
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "仅将两次分部积分后的外负号改为正号，保留原C²和紧支资格。",
      "corrected_decl": "MD.Ch06.fpDiffusionPrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem fpDiffusionPrinted : ∀ (b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ → HasCompactSupport φ →
  (∫ x, b x^2*deriv (deriv φ) x*ρ x)=
    -(∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x)
```

### MD-6.3.6-FPAdjointCompact
```json
{
  "source_id": "MD-6.3.6-FPAdjointCompact",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.6",
  "printed_page": "242",
  "pdf_page": "263",
  "statement_latex": "where the operator appearing on the right hand side is the adjoint $\\mathcal L^*$ of the generator of the stochastic process, satisfying the relation\n\\[\\langle\\mathcal L\\phi,\\rho\\rangle=\\langle\\phi,\\mathcal L^*\\rho\\rangle.\\]\nIn the case at hand the adjoint is\n\\[\\mathcal L^*\\rho=-(a(x)\\rho)_x+\\tfrac12(b^2(x)\\rho)_{xx};\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.fpAdjointCompact",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]紧支撑C²检验的完整正号伴随恒等；多项式检验及指数尾版本另条保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem fpAdjointCompact :
  ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 a → ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ →
  HasCompactSupport φ → (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x) = ∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x
```

### MD-6.3.6-FPPolynomialAdjoint
```json
{
  "source_id": "MD-6.3.6-FPPolynomialAdjoint",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.6",
  "printed_page": "241–242",
  "pdf_page": "262–263",
  "statement_latex": "We assume that $\\rho$ is $C^\\infty$ for all $t$ and that the density tends to zero exponentially fast as $x\\to\\pm\\infty$, whereas $a$ and $b$ are $C^\\infty$ functions which grow at most polynomially fast in these limits.\n\\[\\langle\\mathcal L\\phi,\\rho\\rangle=\\langle\\phi,\\mathcal L^*\\rho\\rangle.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原只给函数值尾部增长而未约束导数；完整IBP及边界消失需技术资格，已全部明示，不静默添加。"
    }
  ],
  "lean_decl": "MD.Ch06.fpPolynomialAdjoint",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原C∞P值增长不足以控制所有IBP边界；明确一、二阶a,b,φ多项式增长及ρ导数指数尾，保存整个非紧支撑真实积分恒等。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "显式约束所需导数的多项式增长和密度导数的指数衰减。",
      "corrected_decl": "MD.Ch06.fpPolynomialAdjoint_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem fpPolynomialAdjoint : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k ≤ 2 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k ≤ 2 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x)
```

### MD-6.3.6-FPEquation
```json
{
  "source_id": "MD-6.3.6-FPEquation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.6",
  "printed_page": "242",
  "pdf_page": "263",
  "statement_latex": "If this is to hold for all test functions $\\phi$, we must have\n\\[\\frac{\\partial\\rho}{\\partial t}=-\\frac\\partial{\\partial x}(a(x)\\rho)+\\frac12\\frac{\\partial^2}{\\partial x^2}(b^2(x)\\rho).\\]\nThe Fokker-Planck equation may be written in the compact form\n\\[\\frac{\\partial\\rho}{\\partial t}=\\mathcal L^*\\rho.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.fpEquation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际严格SDE与其真实平滑非负密度law、局部一致指数尾可求导资格；没有把弱PDE或所求点态PDE当假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem fpEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ) (x0 : ℝ) (ρ : ℝ → ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  strictScalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧
    HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |a x|+|b x| ≤ C*(1+|x|)^r) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*|x|)) →
  ∀ t x : ℝ, 0 < t → deriv (fun s ↦ ρ s x) t=MolecularDynamics.Chapter06Review.scalarForward a b (ρ t) x
```

