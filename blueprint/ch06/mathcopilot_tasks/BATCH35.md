# BATCH35 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.3-BrownianDiscreteSpectrum
```json
{
  "source_id": "MD-6.4.3-BrownianDiscreteSpectrum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.3",
  "printed_page": "250",
  "pdf_page": "271",
  "statement_latex": "In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.brownianDiscreteSpectrum",
  "reusable_proofs": [
    "MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_countable",
    "MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_im_zero",
    "MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_isolated"
  ],
  "extra_assumptions": [
    "[EXTRA]实际闭Gibbs复L²域的全谱，非另选某有限模式；包含可数、实值与每个点孤立。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianDiscreteSpectrum {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ, z.im=0) ∧
  ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    ∃ N : Set ℂ, IsOpen N ∧ z ∈ N ∧
      N ∩ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ={z}
```

### MD-6.4.3-BrownianSpectralGap
```json
{
  "source_id": "MD-6.4.3-BrownianSpectralGap",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.3",
  "printed_page": "251",
  "pdf_page": "272",
  "statement_latex": "$\\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\\sigma(\\mathcal L)\\subset(-\\infty,-\\alpha]$ for some $\\alpha>0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.brownianSpectralGap",
  "reusable_proofs": [
    "MolecularDynamics.textbookBrownianGibbsCoercivityRate_pos",
    "MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_gap",
    "MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_im_zero"
  ],
  "extra_assumptions": [
    "[EXTRA]现成实际全闭谱；正谱隙从真实Poincaré常数得出，不把目标谱隙作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianSpectralGap {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    z ≠ 0 → z.im=0 ∧ z.re ≤ -α
```

### MD-6.4.3-Theorem61
```json
{
  "source_id": "MD-6.4.3-Theorem61",
  "kind": "theorem",
  "label": "Theorem 6.1",
  "section": "6.4.3",
  "printed_page": "250–251",
  "pdf_page": "271–272",
  "statement_latex": "Theorem 6.1 Define the generator of Brownian dynamics by\n\\[\\mathcal Lf\\stackrel{\\rm def}=-M^{-1}\\nabla U^T\\nabla f+\\beta^{-1}\\Delta_Mf.\\]\nSuppose that $U$ is smooth with periodic boundary conditions $\\mathcal Q=\\mathbb T^{N_c}$ ($\\mathbb T^{N_c}$ an $N_c$-dimensional torus). Then, with respect to the space $C_0^2(\\rho_\\beta)$ with inner product $\\langle f,g\\rangle_\\beta$ as defined above, we have:\n1. $\\mathcal L$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $(-\\infty,0]$.\n2. $\\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\\sigma(\\mathcal L)\\subset(-\\infty,-\\alpha]$ for some $\\alpha>0$.\n3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\\varphi$, we have\n\\[|\\bar\\varphi(t)-\\operatorname{Av}_\\beta(\\varphi)|\\le K\\|\\varphi\\|_\\beta e^{-\\alpha t};\\]\nfor some positive $K$ and $\\alpha$, where recall $\\bar\\varphi(t)$ denotes the time average of $\\varphi$ defined in (5.6).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原C₀²核心域、自伴闭实现及negative definite术语需要签核；原末句时间平均与前句分布平均冲突。原一般初始分布未证明，本条技术范围限定另行披露。"
    }
  ],
  "lean_decl": "MD.Ch06.theorem61",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确采用现成闭复Gibbs-L²实现、非正谱和完整离散/谱隙；第三部分选择实际演化分布平均，并限定真实非负质量1的L²初始相对密度。全部条款保留，不用部分桥接代替整个定理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "明确闭Gibbs-L²实现、半负定、离散谱、谱隙和L²初始相对密度的演化分布平均；Brownian扩散使用逆质量权重，不混用p.244动量算子的ΔM；不声称已证原轨道时间平均。",
      "corrected_decl": "MD.Ch06.theorem61_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem theorem61 :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ))
```

### MD-6.4.3-Theorem61TimeAveragePrinted
```json
{
  "source_id": "MD-6.4.3-Theorem61TimeAveragePrinted",
  "kind": "theorem",
  "label": "Theorem 6.1(3) printed time average",
  "section": "6.4.3",
  "printed_page": "251",
  "pdf_page": "272",
  "statement_latex": "Theorem 6.1 Define the generator of Brownian dynamics by\n\\[\\mathcal Lf\\stackrel{\\rm def}=-M^{-1}\\nabla U^T\\nabla f+\\beta^{-1}\\Delta_Mf.\\]\nSuppose that $U$ is smooth with periodic boundary conditions $\\mathcal Q=\\mathbb T^{N_c}$ ($\\mathbb T^{N_c}$ an $N_c$-dimensional torus). Then, with respect to the space $C_0^2(\\rho_\\beta)$ with inner product $\\langle f,g\\rangle_\\beta$ as defined above, we have:\n1. $\\mathcal L$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $(-\\infty,0]$.\n2. $\\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\\sigma(\\mathcal L)\\subset(-\\infty,-\\alpha]$ for some $\\alpha>0$.\n3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\\varphi$, we have\n\\[|\\bar\\varphi(t)-\\operatorname{Av}_\\beta(\\varphi)|\\le K\\|\\varphi\\|_\\beta e^{-\\alpha t};\\]\nfor some positive $K$ and $\\alpha$, where recall $\\bar\\varphi(t)$ denotes the time average of $\\varphi$ defined in (5.6).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "保留原5.6轨道时间平均读法；通常随机时间平均并无原指称指数路径误差界。原文未说明随机量的概率资格，不能改成分布平均后冒称原结论已证。"
    }
  ],
  "lean_decl": "MD.Ch06.theorem61TimeAveragePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Brownian全时torus过程、任意点初值、AE路径资格和t>0明确；原C∞紧支检验在紧torus周期表示。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "选择演化分布平均，限定L²初始相对密度；轨道遍历极限应另行陈述，不赋予指数逐路径率。",
      "corrected_decl": "MD.Ch06.theorem61TimeAveragePrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem theorem61TimeAveragePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
  ∀ x : UnitAddTorus (Fin Nc), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
    ∀ f : textbookPeriodicSmoothSpace Nc, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
      |t⁻¹*(∫ s in (0 : ℝ)..t,
          textbookConfigurationTorusObservable f
            (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample)) -
        (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
          K*‖textbookPeriodicSmoothEmbedding U hU hPU β f‖*Real.exp (-α*t)
```

### MD-6.4.3-BrownianEnsembleExponential
```json
{
  "source_id": "MD-6.4.3-BrownianEnsembleExponential",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.3",
  "printed_page": "251",
  "pdf_page": "272",
  "statement_latex": "averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\\varphi$, we have\n\\[|\\bar\\varphi(t)-\\operatorname{Av}_\\beta(\\varphi)|\\le K\\|\\varphi\\|_\\beta e^{-\\alpha t}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.brownianEnsembleExponential",
  "reusable_proofs": [
    "MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential"
  ],
  "extra_assumptions": [
    "[EXTRA]选择实际演化分布平均；真实Wiener/kernel和非负质量1的L²初始相对密度，所有光滑周期检验同时受界。范围限定不覆盖singular点初始law，不是原轨道时间平均证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianEnsembleExponential {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ))
```

### MD-6.4.3-BrownianNegativeDefinitePrinted
```json
{
  "source_id": "MD-6.4.3-BrownianNegativeDefinitePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.3",
  "printed_page": "250",
  "pdf_page": "271",
  "statement_latex": "so that $\\langle f,\\mathcal Lf\\rangle\\le0$ so the operator is negative definite and can only have non-positive eigenvalues.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "常数非零函数给零二次型，严格负定字面不成立；原非正谱正确子结论独立保留。"
    }
  ],
  "lean_decl": "MD.Ch06.brownianNegativeDefinitePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确严格负定含全部非零周期光滑L²函数的读法。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "将严格小于0改为小于等于0；零特征值与常数核保留。",
      "corrected_decl": "MD.Ch06.brownianNegativeDefinitePrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianNegativeDefinitePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∀ f : (Fin Nc → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0
```

