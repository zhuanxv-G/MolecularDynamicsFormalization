# BATCH40 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.4-WienerControlTube
```json
{
  "source_id": "MD-6.4.4-WienerControlTube",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "256",
  "pdf_page": "277",
  "statement_latex": "The event (6.50) is shown in [349] to have positive probability for any $\\varepsilon>0$, and hence the required property is shown for any open set.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.wienerControlTube",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerVectorRealControlTube_pos"
  ],
  "extra_assumptions": [
    "[EXTRA]完整实际标准多维Wiener法则、真实连续控制R0=0、T/ε>0及sup管道事件；非仅某单时Gaussian边际。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem wienerControlTube {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 < T) (R : ℝ → (Fin Nc → ℝ)) (hR : Continuous R)
    (hR0 : R 0 = 0) (ε : ℝ) (hε : 0 < ε) :
    0 < P (textbookWienerVectorRealControlTube B T R ε)
```

### MD-6.4.4-LangevinCanonicalStationary
```json
{
  "source_id": "MD-6.4.4-LangevinCanonicalStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "256",
  "pdf_page": "277",
  "statement_latex": "Langevin dynamics is geometrically ergodic with respect to the canonical distribution\n\\[\\rho_\\beta(q,p)=\\exp(-\\beta H(q,p)),\\]\nwhere it is easily checked that\n\\[\\mathcal L_{LD}^*\\rho_\\beta=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinCanonicalStationary",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero"
  ],
  "extra_assumptions": [
    "[EXTRA]实际归一canonical density（原式缺Z为未归一权重，常数不影响微分式）、全部相空间点及物理噪声；这里只证stationary differential expression，真实invariance/ergodicity在下一条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinCanonicalStationary {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
      (fun y ↦ textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection y)) z = 0
```

### MD-6.4.4-LangevinGeometricErgodicity
```json
{
  "source_id": "MD-6.4.4-LangevinGeometricErgodicity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "256",
  "pdf_page": "277",
  "statement_latex": "Hence Langevin dynamics is geometrically ergodic with respect to the canonical distribution.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinGeometricErgodicity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际单位周期Langevin完整Gibbs不变/唯一概率及任意l≥1全部可测加权可积观测量的统一指数估计，常数在x/f/t之外；有界周期U使H^l与(1+‖p‖²)^l等价，没有弱化为紧支函数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinGeometricErgodicity :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  MolecularDynamics.Chapter06Review.invariantKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)))
    (textbookLangevinCanonicalMeasure U β hβ) ∧
  (∀ ν : Measure (textbookLangevinPeriodicPhase n), IsProbabilityMeasure ν →
    MolecularDynamics.Chapter06Review.invariantKernel
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) ν →
    ν=textbookLangevinCanonicalMeasure U β hβ) ∧
  ∀ l : ℕ, 1 ≤ l → ∃ C lambdaParam : ℝ, 0 < C ∧ 0 < lambdaParam ∧
    ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
      Measurable f → (∀ y, |f y| ≤ (1+‖y.2‖^2)^l) → ∀ t : ℝ≥0,
      |MolecularDynamics.Chapter06Review.kernelAverage
        (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) f t x
        -(∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)| ≤
        C*(1+‖x.2‖^2)^l*Real.exp (-lambdaParam*(t : ℝ))
```

### MD-6.4.4-LangevinTimeAverage
```json
{
  "source_id": "MD-6.4.4-LangevinTimeAverage",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "256",
  "pdf_page": "277",
  "statement_latex": "Hence averages along solutions to (6.47) will converge to the spatial average with respect to $\\rho_\\beta$. Thus, Langevin dynamics is a useful tool for sampling the canonical distribution, as we may sample $\\rho_\\beta$ by computing solutions to the SDE.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinTimeAverage",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际同一全时随机周期Langevin轨迹，任意点初始状态、全部可测多项式动量增长观测量、几乎处处时间均值；不把初始density的ensemble衰减当轨迹时间均值。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinTimeAverage :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    Measurable f →
    (∃ l : ℕ, ∃ C : ℝ, 0 ≤ C ∧ ∀ y, |f y| ≤ C*(1+‖y.2‖^2)^l) → ∀ᵐ sample ∂P,
      Tendsto (fun T : ℝ ↦ T⁻¹ * ∫ s in 0..T,
        f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2*γ*β⁻¹)) x B s sample))
        atTop (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ))
```

### MD-6.4.4-WeightedH1
```json
{
  "source_id": "MD-6.4.4-WeightedH1",
  "kind": "definition",
  "label": null,
  "section": "6.4.4",
  "printed_page": "256",
  "pdf_page": "277",
  "statement_latex": "We denote by $H^1(\\mu)$ the space of functions $f(q,p)$ defined on $D=\\mathbb T^{N_c}\\times\\mathbb R^{N_c}$ with bounded norm\n\\[\\|f\\|_{H^1(\\mu)}^2\\stackrel{\\mathrm{def}}=\\|f\\|_{L^2(\\mu)}^2+\\|\\nabla_qf\\|_{L^2(\\mu)}^2+\\|\\nabla_pf\\|_{L^2(\\mu)}^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.weightedH1",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Gibbs加权弱导数闭图及AE商的完整Hilbert H1；不是smooth jet子集，函数/导数投影和范数下一条明确。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def weightedH1 {N : ℕ} (U : (Fin N → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) : Type :=
  textbookLangevinCanonicalWeakH1 U hU hp β hβ
```

### MD-6.4.4-WeightedH1Norm
```json
{
  "source_id": "MD-6.4.4-WeightedH1Norm",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "257",
  "pdf_page": "278",
  "statement_latex": "\\[\\|f\\|_{L^2(\\mu)}^2=\\int_D f^2\\mu(d\\omega);\\qquad\n\\|w\\|_{L^2(\\mu)}^2=\\sum_{i=1}^{N_c}\\|w_i\\|_{L^2(\\mu)}^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.weightedH1Norm",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinCanonicalWeakH1_norm_sq"
  ],
  "extra_assumptions": [
    "[EXTRA]实际全部位置/动量弱导数的L²范数平方和；真实函数/弱导数投影定义随compact依赖闭包给出。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem weightedH1Norm {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    ‖f‖ ^ 2 = ‖textbookLangevinCanonicalWeakH1Value U hU hp β hβ f‖ ^ 2 +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inl i) f‖ ^ 2) +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inr i) f‖ ^ 2)
```

### MD-6.4.4-Proposition64Printed
```json
{
  "source_id": "MD-6.4.4-Proposition64Printed",
  "kind": "unnumbered_claim",
  "label": "Proposition 6.4",
  "section": "6.4.4",
  "printed_page": "257",
  "pdf_page": "278",
  "statement_latex": "Proposition 6.4 Let $U$ be $C^\\infty$ on the position domain $Q=\\mathbb T^{N_c}$ and suppose $g\\in H^1(\\mu)$ satisfies\n\\[\\int_D g\\,d\\rho_\\beta=0,\\]\nwhere $\\rho_\\beta$ is the canonical measure, then the Poisson equation\n\\[\\mathcal L_{LD}^*\\varphi=g\\]\nhas a solution $\\varphi\\in H^1(\\mu)$ which is unique up to addition of a constant multiple of the Gibbs density.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "印刷flat forward PDE与Gibbs加权mean-zero/adjoint pairing混用；测度及density-vs-relative-density选择待导师，原式完整保留。"
    }
  ],
  "lean_decl": "MD.Ch06.proposition64Printed",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "选择相对Gibbs密度坐标与真实加权伴随算子，核相应为常数；保留完整H¹解存在与唯一性目标。",
      "corrected_decl": "MD.Ch06.proposition64Printed_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem proposition64Printed :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ)
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ)
          (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x = c*textbookLangevinCanonicalDensity U β x
```

### MD-6.4.4-Proposition64Relative
```json
{
  "source_id": "MD-6.4.4-Proposition64Relative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "257",
  "pdf_page": "278",
  "statement_latex": "\\[\\mathcal L_{LD}^*\\varphi=g.\\] The solution is unique up to addition of a constant multiple of the Gibbs density.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.proposition64Relative",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确相对Gibbs密度坐标，实际加权Hilbert闭算子adjoint图与完整H1、加权零均值、解存在/唯一模常数；与印刷flat-density Gibbs倍数版分列，非静默纠错。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem proposition64Relative :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ,
        textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x=c
```

