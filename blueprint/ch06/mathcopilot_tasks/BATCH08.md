# BATCH08 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.1.5-Equipartition
```json
{
  "source_id": "MD-6.1.5-Equipartition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.5",
  "printed_page": "221",
  "pdf_page": "242",
  "statement_latex": "Then, as we integrate by parts to obtain\n\\[\\operatorname{Av}_\\beta(p^2)=m\\beta^{-1},\\]\nwhich means that $T=\\operatorname{Av}_\\beta\\left(\\frac{p^2}{mk_B}\\right)$.\nIf we consider a $N_c=N$ degree of freedom system with kinetic energy $K=\\sum_{i=1}^N p_i^2/(2m_i)$ and potential energy $U(q_1,q_2,\\ldots,q_N)$, then we may decompose the unnormalized canonical distribution as\n\\[\\exp(-\\beta[K(p)+U(q)])=\\exp(-\\beta K(p))\\exp(-\\beta U(q))\n=\\exp(-\\beta U(q))\\prod_{i=1}^{N_c}\\exp\\left(-\\beta\\frac{p_i^2}{2m_i}\\right).\\]\nThen we again find, by the integration argument given above, that $\\operatorname{Av}_\\beta(m_i^{-1}k_B^{-1}p_i^2)=T$.\n\\[\\operatorname{Av}_\\beta(2K)=Nk_BT.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.equipartition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]标准归一化真实全空间密度、正β及全部正质量；可积且正配置partition；β⁻¹=kBT，完整逐坐标和总动能两项保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem equipartition :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  0 < (∫ q, Real.exp (-β*U q)) →
  (∀ i, (∫ x : MolecularDynamics.Chapter06Review.Phase n, (x.2 i)^2 * MolecularDynamics.Chapter06Review.canonicalDensity volume (MolecularDynamics.Chapter06Review.massHamiltonian m U) β x) = m i/β) ∧
  (∫ x : MolecularDynamics.Chapter06Review.Phase n, (∑ i, (x.2 i)^2/m i) * MolecularDynamics.Chapter06Review.canonicalDensity volume (MolecularDynamics.Chapter06Review.massHamiltonian m U) β x) = n/β
```

### MD-6.1.5-ConfigurationalTemperature
```json
{
  "source_id": "MD-6.1.5-ConfigurationalTemperature",
  "kind": "unnumbered_claim",
  "label": "(6.5)",
  "section": "6.1.5",
  "printed_page": "222",
  "pdf_page": "243",
  "statement_latex": "For example, Rugh suggested the formula\n\\[\\frac{\\operatorname{Av}_\\beta(\\|\\nabla U\\|^2)}{\\operatorname{Av}_\\beta(\\Delta U)}=k_BT.\\tag{6.5}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.configTemperature",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]C²实际U、正β、真实梯度和二阶导数、各加权导数可积及严格正分母；不是将比值等式作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem configTemperature :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  ContDiff ℝ 2 U → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q ^ 2 * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial (textbookConfigurationPartial U i) i q * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q * Real.exp (-β*U q))) →
  0 < (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) →
  (∫ q, (∑ i, textbookConfigurationPartial U i q ^ 2) * Real.exp (-β*U q)) /
    (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) = β⁻¹
```

### MD-6.1.5-Proposition61
```json
{
  "source_id": "MD-6.1.5-Proposition61",
  "kind": "proposition",
  "label": "Proposition 6.1",
  "section": "6.1.5",
  "printed_page": "222",
  "pdf_page": "243",
  "statement_latex": "Proposition 6.1. Let $H$ be a Hamiltonian defined on the phase space $\\mathbb R^{2N}$ and suppose $G:\\mathbb R^{2N}\\to\\mathbb R^{2N}$ is a smooth ($C^1$) vector field with the following properties:\n\\[0<|\\operatorname{Av}_\\beta(G\\cdot\\nabla H)|<\\infty,\\quad\n0<\\operatorname{Av}_\\beta(\\nabla\\cdot G)<\\infty,\\quad |Ge^{-\\beta H}|<\\infty.\\]\nThen\n\\[k_BT=\\frac{\\operatorname{Av}_\\beta(G\\cdot\\nabla H)}{\\operatorname{Av}_\\beta(\\nabla\\cdot G)}.\\]",
  "proof_latex": "The proof relies on a $2N$-dimensional version of integration by parts. Let $B_R$ be the $2N$-dimensional ball centred at the origin, of radius $R$, and let $\\Gamma_R$ be its boundary, the $2N-1$-dimensional sphere. Then, for any smooth scalar field $g$ defined on $B_R$, we have\n\\[\\int_{B_R}G\\cdot\\nabla g\\,d\\omega=\\int_{\\Gamma_R}(Gg)\\cdot\\hat n\\,d\\Gamma-\\int_{B_R}(\\nabla\\cdot G)g\\,d\\omega.\\tag{6.6}\\]\nwhere $d\\omega=d\\omega_1\\ldots d\\omega_N$ is the standard measure of Lebesgue integration in $\\mathbb R^{2N}$, and $d\\Gamma$ is the surface area element of the hypersphere, and $\\hat n$ represents the outward normal of the sphere. Replace $g$ by $\\rho_\\beta=\\exp(-\\beta H)$, it follows that\n\\[\\left|\\int_{\\Gamma_R}(G\\rho_\\beta)\\cdot\\hat n\\,d\\Gamma\\right|\\leq\\max_{\\Gamma_R}|G\\rho_\\beta|\\sigma_R\\]\nwhere $\\sigma_R$ is the surface area of the hypersphere. Divide (6.6) by the volume $v_R$ of $B_R$. Then, for large $R$, since the ratio of surface area to volume is proportional to $R^{-1}$, we have\n\\[\\frac{\\int_{B_R}G\\cdot\\nabla\\rho_\\beta d\\omega}{v_R}\\approx\\frac{-\\int_{B_R}(\\nabla\\cdot G)\\rho_\\beta d\\omega}{v_R}.\\]\nSince $\\nabla\\rho_\\beta=-\\beta\\nabla H\\rho_\\beta$, we obtain, in the limit $R\\to\\infty$, the desired result.",
  "proof_note": "原书完整球边界证明已保留；按体积除法只能给出平均残项，不直接证明所需未缩放IBP。正式库以真实双截断和DCT证明同一结论。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.proposition61",
  "reusable_proofs": [
    "MolecularDynamics.proposition_6_1"
  ],
  "extra_assumptions": [
    "[EXTRA]正kB,T、实际C¹ H,G、Gibbs及两个加权可观测量可积，分母严格正；原|Ge⁻βH|<∞解释为统一有界C≥0，不采用仅逐点有限的空洞条件。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem proposition61 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (kB T : ℝ) (hkB : 0 < kB) (hT : 0 < T) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H (kB * T)⁻¹))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z • G z‖ ≤ C)
    (hpos : 0 < textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)) :
    kB * T =
      textbookCanonicalAverage H (kB * T)⁻¹ (textbookLieDerivative G H) /
        textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)
```

### MD-6.1.5-WeightedFluxZero
```json
{
  "source_id": "MD-6.1.5-WeightedFluxZero",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.5",
  "printed_page": "222",
  "pdf_page": "243",
  "statement_latex": "The proof relies on a $2N$-dimensional version of integration by parts.\nSince $\\nabla\\rho_\\beta=-\\beta\\nabla H\\rho_\\beta$, we obtain, in the limit $R\\to\\infty$, the desired result.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.weightedFluxZero",
  "reusable_proofs": [
    "MolecularDynamics.textbookCanonicalWeightedFlux_integral_divergence_eq_zero"
  ],
  "extra_assumptions": [
    "[EXTRA]真实全空间、原有统一加权场界及可积性，导出实际div(ρG)积分零，不把边界通量消失作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem weightedFluxZero {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    (∫ z, textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z) = 0
```

### MD-6.1.5-CanonicalDivergenceIdentity
```json
{
  "source_id": "MD-6.1.5-CanonicalDivergenceIdentity",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.5",
  "printed_page": "222",
  "pdf_page": "243",
  "statement_latex": "Since $\\nabla\\rho_\\beta=-\\beta\\nabla H\\rho_\\beta$, we obtain, in the limit $R\\to\\infty$, the desired result.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.canonicalDivergenceIdentity",
  "reusable_proofs": [
    "MolecularDynamics.textbookCanonicalAverage_divergence_eq_beta_lieDerivative"
  ],
  "extra_assumptions": [
    "[EXTRA]同一真实全空间、实际权重可积及统一有界场；导出Avβ(divG)=βAvβ(G·∇H)，不假设IBP结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem canonicalDivergenceIdentity {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    textbookCanonicalAverage H β (textbookDivergence G) =
      β * textbookCanonicalAverage H β (textbookLieDerivative G H)
```

### MD-6.1.5-TemperatureChoiceDerivatives
```json
{
  "source_id": "MD-6.1.5-TemperatureChoiceDerivatives",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.5",
  "printed_page": "223",
  "pdf_page": "244",
  "statement_latex": "Observe that, defining $G=(0,p)^T$ yields the kinetic temperature observable $k_BT=\\operatorname{Av}_\\beta(p^TM^{-1}p)/N_c$, whereas $G=(\\nabla U(q),0)^T$ gives the configurational temperature observable (6.5).\nAn even simpler configuration-dependent choice is derived from $G=(q,0)^T$, corresponding to\n\\[k_BT=\\frac{\\operatorname{Av}_\\beta(q\\cdot\\nabla U)}{N_c}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.temperatureChoiceDerivatives",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]保存三个原实际向量场的真实方向导数/分子计算；完整动能、配置温度和virial平均公式分别在Equipartition、ConfigurationalTemperature、VirialTemperature保留，不将分子计算计为完整温度公式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem temperatureChoiceDerivatives :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (q p : MolecularDynamics.Chapter06Review.V n),
  (∀ i, 0 < m i) → ContDiff ℝ 2 U →
  fderiv ℝ (MolecularDynamics.Chapter06Review.massHamiltonian m U) (q,p) (0,p) = ∑ i, p i^2/m i ∧
  fderiv ℝ (MolecularDynamics.Chapter06Review.massHamiltonian m U) (q,p) ((fun i ↦ textbookConfigurationPartial U i q),0) =
    ∑ i, textbookConfigurationPartial U i q ^ 2 ∧
  fderiv ℝ (MolecularDynamics.Chapter06Review.massHamiltonian m U) (q,p) (q,0) = ∑ i, q i * textbookConfigurationPartial U i q
```

### MD-6.1.5-PeriodicBoundaryCancellation
```json
{
  "source_id": "MD-6.1.5-PeriodicBoundaryCancellation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.5",
  "printed_page": "223–224",
  "pdf_page": "244–245",
  "statement_latex": "If $G$ and $H$ are both periodic in $q$ and $G$ is smooth, then everything works since the outward pointing normal will be in opposite directions on each side of the simulation cell, and the boundary term will cancel.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.periodicBoundaryCancellation",
  "reusable_proofs": [
    "MolecularDynamics.textbookConfigurationCube_integral_divergence_eq_zero"
  ],
  "extra_assumptions": [
    "[EXTRA]正式现成单位周期配置cube的真实光滑向量场散度积分；F为实际各分量，可以对固定p取F=Gρ；无穷动量方向仍需原尾部资格，不计所有p积分可积性已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem periodicBoundaryCancellation {Nc : ℕ}
    (F : Fin Nc → (Fin Nc → ℝ) → ℝ)
    (hF : ∀ i, ContDiff ℝ ∞ (F i))
    (hp : ∀ i, textbookUnitPeriodicPotential (F i)) :
    (∫ q in textbookConfigurationCube Nc,
      ∑ i, textbookConfigurationPartial (F i) i q) = 0
```

### MD-6.1.5-PartitionInversePrinted
```json
{
  "source_id": "MD-6.1.5-PartitionInversePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.5",
  "printed_page": "220",
  "pdf_page": "241",
  "statement_latex": "The associated canonical density is\n\\[\\rho_\\beta=Z_{\\rm can}^{-1}\\exp\\left(-\\beta\\left[\\frac{p^2}{2m}+U(q)\\right]\\right),\\]\nwhere\n\\[Z_{\\rm can}^{-1}=\\int_{-\\infty}^{\\infty}\\int_{-\\infty}^{\\infty}\\exp\\left(-\\beta\\left[\\frac{p^2}{2m}+U(q)\\right]\\right)dpdq.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "[ERRATUM?]此页印刷Zcan⁻¹=积分，与p.218的Zcan=积分相反；字面保留，标准DensityNormalization仍按真实积分归一化。"
    }
  ],
  "lean_decl": "MD.Ch06.partitionInversePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "Zcan定义为积分本身；归一密度的结论另见DensityNormalization，避免把定义重述作新定理。",
      "corrected_decl": "MD.Ch06.partitionInversePrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem partitionInversePrinted : ∀ {n : ℕ}
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β →
  Integrable (fun x : MolecularDynamics.Chapter06Review.Phase n ↦
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x))⁻¹ =
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x))
```

