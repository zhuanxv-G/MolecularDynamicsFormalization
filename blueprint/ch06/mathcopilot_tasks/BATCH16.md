# BATCH16 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.2.2-QuadraticSumExpectation
```json
{
  "source_id": "MD-6.2.2-QuadraticSumExpectation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "229",
  "pdf_page": "250",
  "statement_latex": "On the other hand, from (6.7), we have\n\\[\\lim_{K\\to\\infty}\\mathbb E\\sum_{k=0}^{K-1}[(W((k+1)\\delta t)-W(k\\delta t))^2]=\\tau.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.quadraticSumExpectation",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerQuadraticSum_integral"
  ],
  "extra_assumptions": [
    "[EXTRA]实际上每个K>0有限和期望已经恰等于τ；均方极限在Prop6.2保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem quadraticSumExpectation {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, textbookWienerQuadraticSum W T K sample ∂P) = (T : ℝ)
```

### MD-6.2.2-SelfItoLimitL2
```json
{
  "source_id": "MD-6.2.2-SelfItoLimitL2",
  "kind": "extra_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "230",
  "pdf_page": "251",
  "statement_latex": "First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.selfItoLimitL2",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerSelfItoLimit_memLp"
  ],
  "extra_assumptions": [
    "[EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem selfItoLimitL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    MemLp (fun sample ↦ (W T sample ^ 2 - (T : ℝ)) / 2) 2 P
```

### MD-6.2.2-SelfItoSumsL2
```json
{
  "source_id": "MD-6.2.2-SelfItoSumsL2",
  "kind": "extra_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "230",
  "pdf_page": "251",
  "statement_latex": "First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.selfItoSumsL2",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerSelfItoSum_memLp"
  ],
  "extra_assumptions": [
    "[EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem selfItoSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerSelfItoSum W T K) 2 P
```

### MD-6.2.2-MidpointSumsL2
```json
{
  "source_id": "MD-6.2.2-MidpointSumsL2",
  "kind": "extra_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "230",
  "pdf_page": "251",
  "statement_latex": "First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.midpointSumsL2",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerMidpointSum_memLp"
  ],
  "extra_assumptions": [
    "[EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem midpointSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerMidpointSum W T K) 2 P
```

### MD-6.2.2-DeterministicIntegralProcess
```json
{
  "source_id": "MD-6.2.2-DeterministicIntegralProcess",
  "kind": "definition",
  "label": "(6.8)",
  "section": "6.2.2",
  "printed_page": "231",
  "pdf_page": "252",
  "statement_latex": "Also it is natural to view the stochastic integral as the solution of the stochastic differential equation (SDE) with zero initial condition:\n\\[dY(t)=g(t)dW(t);\\quad Y(0)=0.\\tag{6.8}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.deterministicIntegralProcess",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]全部非负时间真实严格L²积分关系；Y0=0从零时间L²极限导出，不能把单时Gaussian独立采样当同一过程。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def deterministicIntegralProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun s _ ↦ g s) T (Y T)
```

### MD-6.2.2-DeterministicStrobePrinted
```json
{
  "source_id": "MD-6.2.2-DeterministicStrobePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "231",
  "pdf_page": "252",
  "statement_latex": "Finally, we observe that by calculating $\\sigma^2(t_n)$ and generating random increments $R_n\\sim N(0,\\sigma(t_n))$ we have a discrete representation of the continuous time stochastic process $Y(t_n)$, effectively an exact stroboscopic representation.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "生成增量使用σ(tn)而非相邻时刻方差差；单时边际法则也不能确定同一过程联合分布。保持印刷式，不以独立边际偷换过程。"
    }
  ],
  "lean_decl": "MD.Ch06.deterministicStrobePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem deterministicStrobePrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  ∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (Real.sqrt (∫ s in (0 : ℝ)..times (k+1), g s^2)).toNNReal) P
```

### MD-6.2.2-DeterministicStrobeCorrected
```json
{
  "source_id": "MD-6.2.2-DeterministicStrobeCorrected",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "231",
  "pdf_page": "252",
  "statement_latex": "Finally, we observe that by calculating $\\sigma^2(t_n)$ and generating random increments $R_n\\sim N(0,\\sigma(t_n))$ we have a discrete representation of the continuous time stochastic process $Y(t_n)$, effectively an exact stroboscopic representation.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.deterministicStrobeCorrected",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]相邻时间积分g²为完整增量方差，并保存整个增量族独立性；不是仅单时law；强L²模型。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem deterministicStrobeCorrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P
```

### MD-6.2.2-StochasticDifferentialIntegral
```json
{
  "source_id": "MD-6.2.2-StochasticDifferentialIntegral",
  "kind": "definition",
  "label": null,
  "section": "6.2.2",
  "printed_page": "231",
  "pdf_page": "252",
  "statement_latex": "Importantly, with appropriate regularity we have the familiar relation from calculus:\n\\[\\int_0^t dY(s)=Y(t)-Y(0).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "积分形式给出dY及其积分的语义关系；不假设普通样本导数存在，不把定义关系计为一般随机链式法则已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.stochasticDifferentialIntegral",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def stochasticDifferentialIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (Y integralOfDifferential : ℝ → Ω → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → integralOfDifferential T =ᵐ[P] (fun sample ↦ Y T sample-Y 0 sample)
```

