# BATCH23 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.5-MixingMemoryLoss
```json
{
  "source_id": "MD-5.5-MixingMemoryLoss",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "205",
  "pdf_page": "226",
  "statement_latex": "We assume $\\beta(z)\\stackrel{\\rm def}{=}\\rho(z;0)/\\rho_E(z)$ is bounded on $\\Sigma_E$, and moreover $\\operatorname{Av}_{H=E}(\\beta)=1$ (i.e., the initial density is a probability density on the energy surface), and that the system is mixing. Then the integral (5.10) is well defined and we may view it as a two-point correlation function of $\\phi$ and $\\beta$. By the mixing property it must converge to $\\int_{\\Sigma_E}\\phi(z)\\rho_Ed\\omega$, thus the average value of $\\phi$ is ultimately independent of the initial conditions. We have\n\\[\\lim_{t\\to\\infty}\\int_{\\Sigma_E}\\phi(\\mathcal F_t(z))(\\beta(z)-1)\\rho_Ed\\omega=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.mixingMemoryLoss",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem mixingMemoryLoss : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (β φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  IsProbabilityMeasure μ → weakMixing μ Φ → Integrable β μ → Bornology.IsBounded (range β) → (∀ z,0 ≤ β z) →
  (∫ z,β z ∂μ)=1 → Continuous φ → Bornology.IsBounded (range φ) →
  (∀ t,MeasurePreserving (Φ t) μ μ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*(β z-1) ∂μ) atTop (𝓝 0)
```

### MD-5.5-MixingCorrelationPrinted
```json
{
  "source_id": "MD-5.5-MixingCorrelationPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "205",
  "pdf_page": "226",
  "statement_latex": "More generally, in a mixing system, if $a$ and $b$ are two arbitrary functions of the phase variables, then\n\\[\\lim_{t\\to\\infty}C_{ab}(t)=\\operatorname{Av}_{H=E}(a)\\operatorname{Av}_{H=E}(b).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.mixingCorrelationPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确概率测度及有界连续函数；k任意，字面版不改最终右侧。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem mixingCorrelationPrinted :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k, IsProbabilityMeasure μ → weakMixing μ Φ → Continuous a → Continuous b →
    Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
    Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b))
```

### MD-5.5-MixingCorrelation
```json
{
  "source_id": "MD-5.5-MixingCorrelation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "205",
  "pdf_page": "226",
  "statement_latex": "$\\lim_{t\\to\\infty}C_{ab}(t)=\\operatorname{Av}_{H=E}(a)\\operatorname{Av}_{H=E}(b)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.mixingCorrelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]独立修正版右侧保留k，实际AC概率初值的弱mixing条件及有界连续a/b；原参考微正则分布的不变资格明确为MeasurePreserving，保障各时积分可积和常数项不变。未以目标相关极限作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem mixingCorrelation :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b))
```

### MD-5.5-CenteredCorrelation
```json
{
  "source_id": "MD-5.5-CenteredCorrelation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "205",
  "pdf_page": "226",
  "statement_latex": "So if either property has mean zero, then the absolute value of the autocorrelation function decays with time to zero.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.centeredCorrelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]概率测度/有界连续资格，k仍保留；由实际混合相关式推导的绝对值结论，不只保留未中心化极限。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem centeredCorrelation : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k,IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) → weakMixing μ Φ →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  (MolecularDynamics.Chapter05Review.average μ a=0 ∨ MolecularDynamics.Chapter05Review.average μ b=0) →
  Tendsto (fun t => |k*(∫ z,a (Φ t z)*b z ∂μ)|) atTop (𝓝 0)
```

