# BATCH34 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.3-BrownianGenerator
```json
{
  "source_id": "MD-6.4.3-BrownianGenerator",
  "kind": "definition",
  "label": "(6.46)",
  "section": "6.4.3",
  "printed_page": "249",
  "pdf_page": "270",
  "statement_latex": "For example, let us return to Brownian dynamics (or overdamped Langevin dynamics) and set $M=I$ and $\\gamma=1$ in (6.36), giving an equation of motion\n\\[dq=-\\nabla U(q)dt+\\sqrt{2k_BT}dW.\\tag{6.46}\\]\nWriting $\\beta^{-1}=k_BT$ as usual, the generator of the stochastic process may be written as\n\\[\\mathcal L f=-\\nabla U^T\\nabla f+\\beta^{-1}\\Delta f.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.brownianGenerator",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际任意对角质量版本，取m≡1即此处公式；不声称原6.46本身含一般质量。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def brownianGenerator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)
```

### MD-6.4.3-BrownianWeightedInner
```json
{
  "source_id": "MD-6.4.3-BrownianWeightedInner",
  "kind": "definition",
  "label": null,
  "section": "6.4.3",
  "printed_page": "249",
  "pdf_page": "270",
  "statement_latex": "Let $\\bar\\rho_\\beta=\\exp(-\\beta U)$, and define the space of functions $C_0^2(\\bar\\rho_\\beta)$ consisting of functions in $C_0^2$ on the configuration space $\\mathcal Q\\subset\\mathbb R^{N_c}$ together with the inner product\n\\[\\langle f,g\\rangle_\\beta\\stackrel{\\rm def}=\\int_{\\mathcal Q}f(q)g(q)\\bar\\rho_\\beta(d\\omega_q)=\\int_{\\mathcal Q}f(q)g(q)\\bar\\rho_\\beta(q)d\\omega_q;\\]\nwhere $d\\omega_q=dq_1dq_2\\cdots dq_{N_c}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.brownianWeightedInner",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]本章后续周期Q的单位基本域；保留原未归一权重，不偷加Z⁻¹。C₀²域与闭算子域另行区别。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def brownianWeightedInner {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ)
    (f g : (Fin n → ℝ) → ℝ) : ℝ :=
  ∫ q in textbookConfigurationCube n, f q*g q*Real.exp (-β*U q)
```

### MD-6.4.3-BrownianDirichlet
```json
{
  "source_id": "MD-6.4.3-BrownianDirichlet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.3",
  "printed_page": "249–250",
  "pdf_page": "270–271",
  "statement_latex": "Combining this with the first part of the inner product, we see that\n\\[\\langle f,\\mathcal Lg\\rangle_\\beta=-\\beta^{-1}\\int_{\\mathcal Q}\\nabla g^T\\nabla f\\bar\\rho_\\beta d\\omega_q.\\]",
  "proof_latex": "\\[\\langle f,\\mathcal Lg\\rangle_\\beta=\\int_{\\mathcal Q}f[-\\nabla U^T\\nabla g+\\beta^{-1}\\Delta g]\\bar\\rho_\\beta d\\omega_q.\\]\nIntegrating by parts in the second term we have\n\\[\\beta^{-1}\\int_{\\mathcal Q}f\\Delta g\\bar\\rho_\\beta d\\omega_q=-\\beta^{-1}\\int_{\\mathcal Q}\\nabla g^T\\nabla(f\\bar\\rho_\\beta)d\\omega_q\n=-\\beta^{-1}\\int_{\\mathcal Q}\\nabla g^T\\nabla f\\bar\\rho_\\beta d\\omega_q+\\int_{\\mathcal Q}f(\\nabla g^T\\nabla U)\\bar\\rho_\\beta d\\omega_q.\\]\nCombining this with the first part of the inner product, we see that\n\\[\\langle f,\\mathcal Lg\\rangle_\\beta=-\\beta^{-1}\\int_{\\mathcal Q}\\nabla g^T\\nabla f\\bar\\rho_\\beta d\\omega_q.\\]",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.brownianDirichlet",
  "reusable_proofs": [
    "MolecularDynamics.textbookBrownianGenerator_integral_dirichlet"
  ],
  "extra_assumptions": [
    "[EXTRA]真实C∞周期资格保证边界通量消去；实际全质量逆M梯度积，m≡1还原原式；β≠0。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianDirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    (∫ q in textbookConfigurationCube Nc,
      f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) =
      -β⁻¹ * ∫ q in textbookConfigurationCube Nc,
        textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q
```

### MD-6.4.3-BrownianSymmetry
```json
{
  "source_id": "MD-6.4.3-BrownianSymmetry",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.3",
  "printed_page": "250",
  "pdf_page": "271",
  "statement_latex": "In this form we see that $f$ and $g$ appear symmetrically, so we may write\n\\[\\langle f,\\mathcal Lg\\rangle_\\beta=\\langle\\mathcal Lf,g\\rangle_\\beta;\\]\nhence, with respect to the weighted inner product, $\\mathcal L=\\mathcal L^*$. (Note that the adjoint indicated here is quite different than the $L^2$ adjoint mentioned previously in connection with the Fokker-Planck operator.)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.brownianSymmetry",
  "reusable_proofs": [
    "MolecularDynamics.textbookBrownianGenerator_inner_symmetric"
  ],
  "extra_assumptions": [
    "[EXTRA]完整未归一配对等式，由现成归一配对消去正Z⁻¹；C∞周期核心上的形式对称，不宣称C₀²核心本身已闭自伴。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianSymmetry {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β g) =
      brownianWeightedInner U β (textbookBrownianGenerator m U β f) g
```

### MD-6.4.3-BrownianNonpositive
```json
{
  "source_id": "MD-6.4.3-BrownianNonpositive",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.3",
  "printed_page": "250",
  "pdf_page": "271",
  "statement_latex": "Moreover, from the calculation above,\n\\[\\langle f,\\mathcal Lf\\rangle=-\\beta^{-1}\\int_{\\mathcal Q}\\|\\nabla f\\|^2\\bar\\rho_\\beta d\\omega_q;\\]\nso that $\\langle f,\\mathcal Lf\\rangle\\le0$ so the operator is negative definite and can only have non-positive eigenvalues.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "常数属于核，≤0只证明半负定，不能升级严格负定。"
    }
  ],
  "lean_decl": "MD.Ch06.brownianNonpositive",
  "reusable_proofs": [
    "MolecularDynamics.textbookBrownianGenerator_inner_nonpos"
  ],
  "extra_assumptions": [
    "[EXTRA]正质量与β>0，未归一配对；本条结论精确保留≤0，原negative definite术语错误另记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "采用≤0并区分闭算子实现与光滑核心；严格负定字面另见BrownianNegativeDefinitePrinted。",
      "corrected_decl": "MD.Ch06.brownianNonpositive_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianNonpositive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0
```

### MD-6.4.3-BrownianRealEigenvalue
```json
{
  "source_id": "MD-6.4.3-BrownianRealEigenvalue",
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
  "issues": [],
  "lean_decl": "MD.Ch06.brownianRealEigenvalue",
  "reusable_proofs": [
    "MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos"
  ],
  "extra_assumptions": [
    "[EXTRA]真正非零L²特征函数、C∞周期、正质量与β>0；不以特征值符号作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianRealEigenvalue {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0
```

### MD-6.4.3-BrownianClosedSelfAdjoint
```json
{
  "source_id": "MD-6.4.3-BrownianClosedSelfAdjoint",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.3",
  "printed_page": "249–250",
  "pdf_page": "270–271",
  "statement_latex": "Then $\\mathcal L$ is self-adjoint with respect to this inner product.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.brownianClosedSelfAdjoint",
  "reusable_proofs": [
    "MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint"
  ],
  "extra_assumptions": [
    "[EXTRA]使用现成实际Gibbs复L²闭实现及完整adjoint域；原C₀²核心对称不等于闭自伴。权重归一不改变自伴关系。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianClosedSelfAdjoint {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ)
```

### MD-6.4.3-BrownianCompactResolvent
```json
{
  "source_id": "MD-6.4.3-BrownianCompactResolvent",
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
  "lean_decl": "MD.Ch06.brownianCompactResolvent",
  "reusable_proofs": [
    "MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact"
  ],
  "extra_assumptions": [
    "[EXTRA]实际Gibbs复L²闭实现的(1−L)⁻¹；全部离散谱子结论另条保留，未从本条自动声称原C₀²域自伴。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem brownianCompactResolvent {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ)
```

