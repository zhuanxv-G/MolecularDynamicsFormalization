# BATCH15 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.2.2-WienerMidpointSum
```json
{
  "source_id": "MD-6.2.2-WienerMidpointSum",
  "kind": "definition",
  "label": null,
  "section": "6.2.2",
  "printed_page": "228",
  "pdf_page": "249",
  "statement_latex": "The choice $t_k=k\\delta t$ (left endpoint) and the choice $t_k=(k+1/2)\\delta t$ yield different formulas for the integral. The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "g=W时真实时间中点W((k+1/2)δt)；一般g中点定义另列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.wienerMidpointSum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def wienerMidpointSum {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun sample ↦ ∑ k : Fin K, W (textbookWienerTime T (2 * K) (2 * k.val + 1)) sample *
    textbookWienerIncrement W T K k sample
```

### MD-6.2.2-GaussianIncrementMean
```json
{
  "source_id": "MD-6.2.2-GaussianIncrementMean",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "230",
  "pdf_page": "251",
  "statement_latex": "Also observe that $\\Delta W_k$ is a normally distributed random variable with the following properties\n\\[\\mathbb E\\Delta W_k=0;\\quad\\mathbb E\\Delta W_k^2=\\delta t=\\tau/K;\\quad\\mathbb E\\Delta W_k^4=3\\delta t^2=3(\\tau/K)^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.gaussianIncrementMean",
  "reusable_proofs": [
    "ProbabilityTheory.HasLaw.integral_eq",
    "ProbabilityTheory.integral_id_gaussianReal"
  ],
  "extra_assumptions": [
    "[EXTRA]任意真实中心Gaussian完整法则推出零均值；增量law桥接先前已保存。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gaussianIncrementMean {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    {X : Ω → ℝ} {v : ℝ≥0} (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ∂P) = 0
```

### MD-6.2.2-GaussianIncrementSecond
```json
{
  "source_id": "MD-6.2.2-GaussianIncrementSecond",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "230",
  "pdf_page": "251",
  "statement_latex": "Also observe that $\\Delta W_k$ is a normally distributed random variable with the following properties\n\\[\\mathbb E\\Delta W_k=0;\\quad\\mathbb E\\Delta W_k^2=\\delta t=\\tau/K;\\quad\\mathbb E\\Delta W_k^4=3\\delta t^2=3(\\tau/K)^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.gaussianIncrementSecond",
  "reusable_proofs": [
    "MolecularDynamics.textbookCenteredGaussian_secondMoment"
  ],
  "extra_assumptions": [
    "[EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gaussianIncrementSecond {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 2 ∂P) = (v : ℝ)
```

### MD-6.2.2-GaussianIncrementFourth
```json
{
  "source_id": "MD-6.2.2-GaussianIncrementFourth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "230",
  "pdf_page": "251",
  "statement_latex": "Also observe that $\\Delta W_k$ is a normally distributed random variable with the following properties\n\\[\\mathbb E\\Delta W_k=0;\\quad\\mathbb E\\Delta W_k^2=\\delta t=\\tau/K;\\quad\\mathbb E\\Delta W_k^4=3\\delta t^2=3(\\tau/K)^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.gaussianIncrementFourth",
  "reusable_proofs": [
    "MolecularDynamics.textbookCenteredGaussian_fourthMoment"
  ],
  "extra_assumptions": [
    "[EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gaussianIncrementFourth {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 4 ∂P) = 3 * (v : ℝ) ^ 2
```

### MD-6.2.2-QuadraticMeanSquareError
```json
{
  "source_id": "MD-6.2.2-QuadraticMeanSquareError",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "230",
  "pdf_page": "251",
  "statement_latex": "Thus we have\n\\[I=\\sum_{k=0}^{K-1}\\mathbb E(\\Delta W_{K,k}^2-\\delta t)^2\n=\\sum_{k=0}^{K-1}\\mathbb E[\\Delta W_{K,k}^4-2\\delta t\\Delta W_{K,k}^2+\\delta t^2]\n=\\sum_{k=0}^{K-1}[3\\delta t^2-2\\delta t^2+\\delta t^2]=2K\\delta t^2=2\\tau^2/K.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.quadraticMeanSquareError",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerQuadraticSum_meanSquareError"
  ],
  "extra_assumptions": [
    "[EXTRA]实际PreBrownian且K>0；精确误差，不是仅Tendsto0。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem quadraticMeanSquareError {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) =
      2 * (T : ℝ) ^ 2 / (K : ℝ)
```

### MD-6.2.2-SelfItoIntegral
```json
{
  "source_id": "MD-6.2.2-SelfItoIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "230",
  "pdf_page": "251",
  "statement_latex": "The calculation implies that\n\\[\\int_0^\\tau W(t)dW(t)=\\frac12(W(\\tau)^2-\\tau).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.selfItoIntegral",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerSelfItoIntegral_exists"
  ],
  "extra_assumptions": [
    "[EXTRA]真实L²见证、全均方收敛及AE求值三项保留；有限和L²另条补足。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem selfItoIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerSelfItoSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = (W T sample ^ 2 - (T : ℝ)) / 2
```

### MD-6.2.2-SelfStratonovichIntegral
```json
{
  "source_id": "MD-6.2.2-SelfStratonovichIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "230",
  "pdf_page": "251",
  "statement_latex": "In contrast, the Stratonovich (midpoint) integral can be calculated as\n\\[\\int_0^\\tau W(t)\\circ dW(t)=\\operatorname{l.i.m.}_{K\\to\\infty}\\sum_{k=0}^{K-1}W(k\\delta t+\\delta t/2)[W((k+1)\\delta t)-W(k\\delta t)].\\]\nWriting\n\\[W(k\\delta t+\\delta t/2)=W(\\frac{(k+1)\\delta t+k\\delta t}{2})=\\frac12(W((k+1)\\delta t)+W(k\\delta t))+O(\\sqrt{\\delta t}),\\]\nallows us to evaluate the integral as\n\\[\\int_0^\\tau W(t)\\circ dW(t)=\\frac12\\operatorname{l.i.m.}_{K\\to\\infty}\\sum_{k=0}^{K-1}[W((k+1)\\delta t)^2-W(k\\delta t)^2]=\\frac12W(\\tau)^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.selfStratonovichIntegral",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists"
  ],
  "extra_assumptions": [
    "[EXTRA]真实时间中点和、L²见证、整体均方极限、AE求值；原O(√δt)单步启发不足，正式整体均方误差证明不直接丢弃逐步残项。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem selfStratonovichIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerMidpointSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = W T sample ^ 2 / 2
```

### MD-6.2.2-Proposition63
```json
{
  "source_id": "MD-6.2.2-Proposition63",
  "kind": "proposition",
  "label": "Proposition 6.3",
  "section": "6.2.2",
  "printed_page": "231",
  "pdf_page": "252",
  "statement_latex": "Proposition 6.3 Let $g$ be a smooth deterministic function and $W(t)$ a Wiener process. The stochastic integral $Y(t)=\\int_0^t g(s)dW(s)$ is, for all times $t\\geq0$, a normally distributed random variable such that\n\\[\\mathbb E(Y(t))=0;\\quad\\mathbb E(Y^2(t))=\\sigma^2(t)=\\int_0^t g(s)^2ds.\\]",
  "proof_latex": "See Exercise 2.",
  "proof_note": "原书仅指向习题；按本任务不转录习题。现成正式构造证明桥接。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.proposition63",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerDeterministicIto_proposition63"
  ],
  "extra_assumptions": [
    "[EXTRA]实际PreBrownian与C¹ g已足；完整构造L²见证、均方极限、Gaussian law、零均值及二阶矩，不仅保存矩。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem proposition63 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerDeterministicSum W g T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧
      HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P ∧
      (∫ sample, Y sample ∂P) = 0 ∧ (∫ sample, Y sample ^ 2 ∂P) = ∫ x in (0 : ℝ)..T, g x ^ 2
```

