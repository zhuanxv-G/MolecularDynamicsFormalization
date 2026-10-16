# BATCH13 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.2.1-GridWienerIncrementLaw
```json
{
  "source_id": "MD-6.2.1-GridWienerIncrementLaw",
  "kind": "extra_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "227",
  "pdf_page": "248",
  "statement_latex": "For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.gridWienerIncrementLaw",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerIncrement_hasLaw"
  ],
  "extra_assumptions": [
    "[EXTRA]等距T/K网格完整Gaussian法则；任意时刻原结论另条WienerIncrement保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gridWienerIncrementLaw {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (k : Fin K) :
    HasLaw (textbookWienerIncrement W T K k) (gaussianReal 0 (T / (K : ℝ≥0))) P
```

### MD-6.2.1-GridIncrementIndependent
```json
{
  "source_id": "MD-6.2.1-GridIncrementIndependent",
  "kind": "extra_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "227",
  "pdf_page": "248",
  "statement_latex": "this does not depend on whether there is additional information available regarding its value prior to $\\min(t,s)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.gridIncrementIndependent",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerIncrement_independent"
  ],
  "extra_assumptions": [
    "[EXTRA]实际等距有限增量族iIndepFun；整条未来路径独立在上一条保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gridIncrementIndependent {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) :
    iIndepFun (textbookWienerIncrement W T K) P
```

### MD-6.2.1-WienerContinuousPathEval
```json
{
  "source_id": "MD-6.2.1-WienerContinuousPathEval",
  "kind": "extra_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "226–227",
  "pdf_page": "247–248",
  "statement_latex": "an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.wienerContinuousPathEval",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerVectorContinuousPath_eval"
  ],
  "extra_assumptions": [
    "[EXTRA]给定连续样本的真实C([0,T],ℝⁿ)值与所有时刻原路径一致；不证明从PreBrownian构造连续修改。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem wienerContinuousPathEval {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (t : Icc 0 T) :
    textbookWienerVectorContinuousPath B T sample t = B ⟨t.1, t.2.1⟩ sample
```

### MD-6.2.1-WienerContinuousPathMeasurable
```json
{
  "source_id": "MD-6.2.1-WienerContinuousPathMeasurable",
  "kind": "extra_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "226–227",
  "pdf_page": "247–248",
  "statement_latex": "an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.wienerContinuousPathMeasurable",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerVectorContinuousPath_aemeasurable"
  ],
  "extra_assumptions": [
    "[EXTRA]给定真实连续Wiener模型导出整个连续路径空间AE可测性；不是将路径可测结论作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem wienerContinuousPathMeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (T : ℝ) :
    AEMeasurable (textbookWienerVectorContinuousPath B T) P
```

### MD-6.2.1-CoarseMarkovPrinted
```json
{
  "source_id": "MD-6.2.1-CoarseMarkovPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "227",
  "pdf_page": "248",
  "statement_latex": "Let $A(x)$, $B(x)$ and $C(x)$ be three events dependent on state variable $x$, and let $t_+>t_0>t_-$ be three times, then, for a Markov process $X(t)$ we have (using the notation for conditional probability):\n\\[\\Pr[A(X(t_+))\\mid B(X(t_0)),C(X(t_-))]=\\Pr[A(X(t_+))\\mid B(X(t_0))].\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "印刷用任意粗事件B(X(t0))替代完整当前状态的条件σ代数；一般不成立，例如B=univ时过去事件仍可影响未来。"
    }
  ],
  "lean_decl": "MD.Ch06.coarseMarkovPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem coarseMarkovPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∀ (a b c : Set ℝ) (past present future : ℝ≥0),
    MeasurableSet a → MeasurableSet b → MeasurableSet c → past < present → present < future →
    0 < P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) →
    P ((W future ⁻¹' a) ∩ ((W present ⁻¹' b) ∩ (W past ⁻¹' c))) /
      P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) =
    P ((W future ⁻¹' a) ∩ (W present ⁻¹' b)) / P (W present ⁻¹' b)
```

### MD-6.2.1-StateMarkovMeaning
```json
{
  "source_id": "MD-6.2.1-StateMarkovMeaning",
  "kind": "definition",
  "label": null,
  "section": "6.2.1",
  "printed_page": "227",
  "pdf_page": "248",
  "statement_latex": "More generally, when we say that a stochastic process is Markovian, we mean that the probability of a future event conditioned on the current state of the process and the past history of the process is the same as the probability conditioned on the current state of the process.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.stateMarkovMeaning",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确以真实当前状态σ(Xs)及过去history作条件期望；仅定义完整Markov意义，不计任意过程满足它已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def stateMarkovMeaning {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))
```

