# BATCH03 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.1.2-BathMeanValue
```json
{
  "source_id": "MD-6.1.2-BathMeanValue",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.2",
  "printed_page": "216",
  "pdf_page": "237",
  "statement_latex": "we (naively) apply the mean value theorem to $S_B$ to obtain\n\\[S_B(E-s)=S_B(E)-S'_B(\\xi)s.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.bathMeanValue",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]C¹熵且s>0；只保留真实均值定理，不把ξ处导数改为E处导数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bathMeanValue : ∀ (S : ℝ → ℝ) (energy s : ℝ),
  ContDiff ℝ 1 S → 0 < s → ∃ ξ ∈ Ioo (energy-s) energy,
    S (energy-s) = S energy - deriv S ξ * s
```

### MD-6.1.2-BathTaylorEstimate
```json
{
  "source_id": "MD-6.1.2-BathTaylorEstimate",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.2",
  "printed_page": "216",
  "pdf_page": "237",
  "statement_latex": "Since $Z_B(E-s)=\\exp(S_B(E-s)/k_B)$, and $s\\ll E$, we (naively) apply the mean value theorem to $S_B$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.bathTaylorEstimate",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]对原页热浴近似给出可核验的局部C²一阶展开及C·s²余项；这是额外严格表述，完整字面Boltzmann关系仍为NEEDS_HUMAN。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bathTaylorEstimate :
  ∀ (S : ℝ → ℝ) (E : ℝ), ContDiff ℝ 2 S →
  ∃ C δ : ℝ, 0 ≤ C ∧ 0 < δ ∧ ∀ e, |e| < δ →
    |S (E-e)-S E+deriv S E*e| ≤ C*e^2
```

### MD-6.1.2-BoltzmannConstantSlope
```json
{
  "source_id": "MD-6.1.2-BoltzmannConstantSlope",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.2",
  "printed_page": "216",
  "pdf_page": "237",
  "statement_latex": "and from $S'_B(\\xi)=1/T$, we obtain\n\\[Z_B(E-s)\\propto\\exp(-\\beta s),\\qquad \\beta=(k_BT)^{-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.boltzmannConstantSlope",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]理想恒温热浴明确要求熵导数在整个实轴恒定；不从固定能量的温度偷推出该条件，不将本条代替字面版。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem boltzmannConstantSlope : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  Differentiable ℝ S → 0 < kB → (∀ e, deriv S e = kB * β) →
  ∀ s, Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s)
```

### MD-6.1.2-CanonicalCDFPrinted
```json
{
  "source_id": "MD-6.1.2-CanonicalCDFPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.2",
  "printed_page": "216",
  "pdf_page": "237",
  "statement_latex": "On the other hand the probability for the active system to have energy $\\leq\\alpha$ is the same as the probability of the bath having energy $\\geq E-\\alpha$, this must be\n\\[P(\\alpha)=\\Pr\\{E_B\\geq E-\\alpha\\}\\propto\\int_0^\\alpha Z_B(E-s)ds.\\]\nThus we have $P(\\alpha)\\propto\\int_0^\\alpha\\exp(-\\beta s)ds$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "[ERRATUM?]页末能量密度含ZA(α)，此前CDF却省略ZA(s)权重；一般ZA下两归一化CDF不相等。"
    }
  ],
  "lean_decl": "MD.Ch06.canonicalCDFPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem canonicalCDFPrinted : ∀ (ZA ZB : ℝ → ℝ) (energy α : ℝ),
  Continuous ZA → Continuous ZB → (∀ e, 0 < ZA e) → (∀ e, 0 < ZB e) →
  0 < α → α < energy →
  (∫ s in 0..α, ZA s * ZB (energy-s)) / (∫ s in 0..energy, ZA s * ZB (energy-s)) =
  (∫ s in 0..α, ZB (energy-s)) / (∫ s in 0..energy, ZB (energy-s))
```

### MD-6.1.2-CanonicalEnergyDensity
```json
{
  "source_id": "MD-6.1.2-CanonicalEnergyDensity",
  "kind": "definition",
  "label": null,
  "section": "6.1.2",
  "printed_page": "216",
  "pdf_page": "237",
  "statement_latex": "The volume (or number, in the case of discrete systems) of states available at energy $\\alpha$ is $Z_A(\\alpha)$. Thus the energy density of the canonical ensemble at energy level $\\alpha$ is proportional to $Z_A(\\alpha)\\exp(-\\beta\\alpha)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整能量权重ZA保留，实轴能量积分归一化；若能量域限制非负，则ZA在负半轴取零；正有限分母才有概率密度解释。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.canonicalEnergyDensity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def canonicalEnergyDensity (Z : ℝ → ℝ) (β E : ℝ) : ℝ :=
  Z E * Real.exp (-β * E) / (∫ e, Z e * Real.exp (-β * e))
```

