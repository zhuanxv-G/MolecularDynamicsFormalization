# BATCH30 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.2-LangevinCanonicalMixing
```json
{
  "source_id": "MD-6.4.2-LangevinCanonicalMixing",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.2",
  "printed_page": "248",
  "pdf_page": "269",
  "statement_latex": "Even a single phase space point, which corresponds to a delta-function initial distribution, will instantly diffuse as the solution of the Fokker-Planck equation and, eventually, would cover the entire phase space.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinCanonicalMixing",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实现有周期单位质量Langevin kernel、正γ/β、原光滑力全局Lipschitz；完整任意点初值的正时刻严格正连续转移密度以及全部有界连续检验弱混合，原一般混合意义另条，不以单位质量特例替代一般定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinCanonicalMixing :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β γ : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
  textbookIsWienerVector B P → 0 < γ →
  (∀ t : ℝ≥0, 0 < t → ∃ density : textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n → ℝ,
    Continuous density ∧ (∀ x y, 0 < density (x,y)) ∧
    ∀ x, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t x =
        (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun y ↦ ENNReal.ofReal (density (x,y)))) ∧
  ∀ x : textbookLangevinPeriodicPhase n,
    ∀ f : textbookLangevinPeriodicPhase n → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t.toNNReal x) atTop
        (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ))
```

### MD-6.4.2-OUDensityPrinted
```json
{
  "source_id": "MD-6.4.2-OUDensityPrinted",
  "kind": "definition",
  "label": "(6.44)–(6.45)",
  "section": "6.4.2",
  "printed_page": "248",
  "pdf_page": "269",
  "statement_latex": "The solution $p(t)$ to the Ornstein-Uhlenbeck equation, for any finite time $t$, is always normally distributed\n\\[\\rho(p,t)=\\exp\\left[-\\frac{(p-\\mu(t))^2}{2\\sigma(t)^2}\\right];\\tag{6.44}\\]\nwhere\n\\[\\mu(t)=p_0e^{-\\gamma t};\\qquad\\sigma^2(t)=k_BT m[1-e^{-2\\gamma t}].\\tag{6.45}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "(6.44)遗漏(2πσ²(t))⁻¹/²归一化系数；t=0为Dirac，不能声称每个有限t都是非退化Lebesgue密度。"
    }
  ],
  "lean_decl": "MD.Ch06.ouDensityPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]定义中使用通用噪声σ，取σ=√(2γkBTm)即6.45；t=0资格另记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def ouDensityPrinted (γ σ x0 t x : ℝ) : ℝ :=
  Real.exp (-(x-MolecularDynamics.Chapter06Review.ouMean γ x0 t)^2/(2*MolecularDynamics.Chapter06Review.ouVariance γ σ t))
```

### MD-6.4.2-OUDensityCorrect
```json
{
  "source_id": "MD-6.4.2-OUDensityCorrect",
  "kind": "definition",
  "label": "(6.44) correction",
  "section": "6.4.2",
  "printed_page": "248",
  "pdf_page": "269",
  "statement_latex": "The solution $p(t)$ to the Ornstein-Uhlenbeck equation, for any finite time $t$, is always normally distributed\n\\[\\rho(p,t)=\\exp\\left[-\\frac{(p-\\mu(t))^2}{2\\sigma(t)^2}\\right];\\tag{6.44}\\]\nwhere\n\\[\\mu(t)=p_0e^{-\\gamma t};\\qquad\\sigma^2(t)=k_BT m[1-e^{-2\\gamma t}].\\tag{6.45}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.ouDensity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]补归一化系数，正γ/温度/质量且t>0使用；仅实际密度公式定义，原OU严格law结论在§6.3.2保留，不计密度积分或过程law已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def ouDensity (γ σ x0 t x : ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*MolecularDynamics.Chapter06Review.ouVariance γ σ t)
```

