# BATCH12 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.2.1-WalkGridMoments
```json
{
  "source_id": "MD-6.2.1-WalkGridMoments",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "226",
  "pdf_page": "247",
  "statement_latex": "Let us observe the following facts, for $0\\leq k\\leq l\\leq\\nu$\n\\[(i)\\quad\\mathbb E(Y_l-Y_k)=0,\\qquad(ii)\\quad\\operatorname{Var}(Y_l-Y_k)=t_l-t_k.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.walkGridMoments",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际独立公平L²跳跃、正δt和k≤l；保存零均值与完整增量二阶矩，不假设这些结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem walkGridMoments :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dt : ℝ) (k l : ℕ), MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < dt → k ≤ l →
  (∫ sample, MolecularDynamics.Chapter06Review.diffusiveWalk J dt l sample-MolecularDynamics.Chapter06Review.diffusiveWalk J dt k sample ∂P) = 0 ∧
  (∫ sample, (MolecularDynamics.Chapter06Review.diffusiveWalk J dt l sample-MolecularDynamics.Chapter06Review.diffusiveWalk J dt k sample)^2 ∂P) = ((l : ℝ)-k)*dt
```

### MD-6.2.1-InterpolatedWalkMean
```json
{
  "source_id": "MD-6.2.1-InterpolatedWalkMean",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "226",
  "pdf_page": "247",
  "statement_latex": "Then, for $0\\leq t\\leq s\\leq\\tau$, we have\n\\[\\mathbb E(Y(s)-Y(t))=0.\\]\nThis is easy to demonstrate. However, the intuitive corresponding statement $\\operatorname{Var}(Y(s)-Y(t))=(s-t)$ does not quite hold due to the reliance on interpolation.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.interpolatedWalkMean",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实线性插值均值；任意有限正时间可置于τ窗口，不声称精确插值方差等于s−t。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem interpolatedWalkMean : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (J : ℕ → Ω → ℝ) (dt t s : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < dt → 0 ≤ t → t ≤ s →
  (∫ sample, MolecularDynamics.Chapter06Review.interpolatedWalk J dt s sample -
    MolecularDynamics.Chapter06Review.interpolatedWalk J dt t sample ∂P) = 0
```

### MD-6.2.1-WalkDiffusion
```json
{
  "source_id": "MD-6.2.1-WalkDiffusion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "226–227",
  "pdf_page": "247–248",
  "statement_latex": "In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process (after Norbert Wiener).\n\\[W(t)=\\lim_{\\delta t\\to0}^{c}\\sqrt{\\delta t}\\sum_{k=0}^{\\lfloor t/\\delta t\\rfloor}J_k.\\]\nThe convergence here, signified by the symbol $\\lim^c$ is in the sense of distributions.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.walkDiffusion",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整连续路径空间C([0,T],ℝ)弱法则、各时Gaussian边际、独立增量和全部有界连续路径检验函数；使用实际线性插值的n项和，不将单时CLT计为路径Donsker已证。",
    "[EXTRA]印刷含端点的多一项有限和与标准n项版本之差在扩散极限消失须另核；连续版本和不可微性质另条保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem walkDiffusion :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (T : ℝ), MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < T →
  ∃ μ : Measure (C(Icc (0 : ℝ) T, ℝ)), IsProbabilityMeasure μ ∧
    (∀ t : Icc (0 : ℝ) T, μ.map (fun w ↦ w t) = gaussianReal 0 t.1.toNNReal) ∧
    (∀ s t : Icc (0 : ℝ) T, s ≤ t →
      HasLaw (fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w t-w s) (gaussianReal 0 (t.1-s.1).toNNReal) μ) ∧
    (∀ k : ℕ, ∀ ts : Fin (k+1) → Icc (0 : ℝ) T, Monotone ts →
      iIndepFun (fun i : Fin k ↦ fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w (ts i.succ)-w (ts i.castSucc)) μ) ∧
    ∀ F : C(Icc (0 : ℝ) T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
      ∃ Y : ℕ → Ω → C(Icc (0 : ℝ) T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample t, Y K sample t = MolecularDynamics.Chapter06Review.interpolatedWalk J (T/K) t sample) ∧
        Tendsto (fun K ↦ ∫ sample, F (Y K sample) ∂P) atTop (𝓝 (∫ w, F w ∂μ))
```

### MD-6.2.1-WienerVector
```json
{
  "source_id": "MD-6.2.1-WienerVector",
  "kind": "definition",
  "label": null,
  "section": "6.2.1",
  "printed_page": "227",
  "pdf_page": "248",
  "statement_latex": "As we take $n$ to infinity, $\\delta t$ to zero, in such a way that $n\\delta t\\to t$, we obtain the random variable $W(t)$ such that\n\\[W(t)\\sim N(0,t).\\]\nFor the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "正式真实结构的别名：联合Gaussian、零均值、min(s,t)各坐标协方差及AE连续路径；定义的连续性资格不计为从PreBrownian或随机游走构造连续过程已证。",
    "原页单时CLT和整个路径扩散极限分别处理；标量一般时刻法则在WienerIncrement中保留。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.wienerVector",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def wienerVector {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) : Prop :=
  MolecularDynamics.textbookIsWienerVector B P
```

### MD-6.2.1-WienerIncrement
```json
{
  "source_id": "MD-6.2.1-WienerIncrement",
  "kind": "unnumbered_claim",
  "label": "(6.7)",
  "section": "6.2.1",
  "printed_page": "227",
  "pdf_page": "248",
  "statement_latex": "Moreover, we may easily demonstrate that\n\\[\\mathbb E(W(t)-W(s))^2=|t-s|.\\tag{6.7}\\]\nFor the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.wienerIncrement",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际IsPreBrownianReal模型、任意非负s,t、完整Gaussian法则与二阶矩；不局限等距网格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem wienerIncrement :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P → ∀ s t : ℝ≥0,
      HasLaw (fun sample ↦ W t sample-W s sample) (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P ∧
      (∫ sample, (W t sample-W s sample)^2 ∂P)=|((t : ℝ)-s)|
```

### MD-6.2.1-WienerContinuousVersion
```json
{
  "source_id": "MD-6.2.1-WienerContinuousVersion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "226–227",
  "pdf_page": "247–248",
  "statement_latex": "In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.wienerContinuousVersion",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]从实际PreBrownian Gaussian法则构造AE连续修改，保持每个时刻AE一致；不将连续性本身作存在连续版本定理的前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem wienerContinuousVersion :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∃ V : ℝ≥0 → Ω → ℝ, (∀ t, W t =ᵐ[P] V t) ∧ ∀ᵐ sample ∂P, Continuous (fun t ↦ V t sample)
```

### MD-6.2.1-WienerNondifferentiable
```json
{
  "source_id": "MD-6.2.1-WienerNondifferentiable",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "226–227",
  "pdf_page": "247–248",
  "statement_latex": "In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.wienerNondifferentiable",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际PreBrownian法则与连续路径版本，结论AE每个正时刻不可微；不将不可微性作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem wienerNondifferentiable :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  (∀ᵐ sample ∂P, Continuous (fun t : ℝ≥0 ↦ W t sample)) →
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t → ¬ DifferentiableAt ℝ (fun s ↦ W s.toNNReal sample) t
```

### MD-6.2.1-WienerFutureCompletedHistory
```json
{
  "source_id": "MD-6.2.1-WienerFutureCompletedHistory",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "227",
  "pdf_page": "248",
  "statement_latex": "For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$; this does not depend on whether there is additional information available regarding its value prior to $\\min(t,s)$, that is to say, the Wiener process is a Markov process.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.wienerFutureCompletedHistory",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerVectorFuture_independent_completed_filtration"
  ],
  "extra_assumptions": [
    "[EXTRA]真实多维Wiener、真实未来连续路径与整个零集完成的过去filtration独立；独立对象全部保留。粗事件条件概率式另条疑误，不将本条视为该式证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem wienerFutureCompletedHistory
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) (T : ℝ) :
    Indep ((inferInstance : MeasurableSpace C(Icc (0 : ℝ) T, Fin Nc → ℝ)).comap
        (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T))
      (textbookWienerVectorCompletedFiltration B P hB S) P.completion
```

