# BATCH05 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.1.3-FiniteDomainPrinted
```json
{
  "source_id": "MD-6.1.3-FiniteDomainPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "218",
  "pdf_page": "239",
  "statement_latex": "If $U$ is smooth and the domain $Q$ is finite, then clearly both integrals are well defined, so the normalization is sensible.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "[ERRATUM?]仅有限体积、Q内部光滑不足以排除趋向边界的U→−∞；需要下界、紧域上的连续性或权重可积性。"
    }
  ],
  "lean_decl": "MD.Ch06.finiteDomainPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem finiteDomainPrinted : ∀ {n : ℕ} (Q : Set (MolecularDynamics.Chapter06Review.V n))
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  MeasurableSet Q → (volume : Measure (MolecularDynamics.Chapter06Review.V n)) Q < ⊤ →
  ContDiffOn ℝ ∞ U Q → 0 < β → IntegrableOn (fun q ↦ Real.exp (-β*U q)) Q
```

### MD-6.1.3-PeriodicPartitionBridge
```json
{
  "source_id": "MD-6.1.3-PeriodicPartitionBridge",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "218",
  "pdf_page": "239",
  "statement_latex": "then the integral separates\n\\[Z_{\\rm can}=\\int_{\\mathbb R^{N_c}}e^{-\\beta p^TM^{-1}p/2}d\\omega_p\\times\\int_Q e^{-\\beta U(q)}d\\omega_q.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.periodicPartitionBridge",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinCanonicalPartition_formula"
  ],
  "extra_assumptions": [
    "[EXTRA]仅独立特例：单位质量、单位周期torus、实际Haar配置测度与光滑周期U；完整一般质量/Q的两条义务仍保留，不将特例计为完整原结论已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem periodicPartitionBridge {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalPartition U β =
      textbookConfigurationPartition U β * (Real.sqrt (2 * Real.pi * β⁻¹)) ^ N
```

### MD-6.1.3-ConfiningPartition
```json
{
  "source_id": "MD-6.1.3-ConfiningPartition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "218–220",
  "pdf_page": "239–241",
  "statement_latex": "Typically one assumes that (i) $U$ is smooth except on a low-dimensional set of singular points, (ii) $U$ is bounded below, and (iii) $U$ grows sufficiently rapidly as $q\\to\\infty$, in the case of an infinite domain.\nThis ensures that\n\\[\\int_\\Omega\\exp(-\\beta U(q))d\\omega_q<\\infty.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.confiningPartition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]无奇点的连续全空间充分条件：U(q)≥c‖q‖ᵖ−C，其中c,p,β>0；把“足够快”明确量化，不将任意增长都视为足够。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem confiningPartition :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β c p C : ℝ),
  Continuous U → 0 < β → 0 < c → 0 < p →
  (∀ q, c*Real.rpow ‖q‖ p-C ≤ U q) → Integrable (fun q ↦ Real.exp (-β*U q))
```

### MD-6.1.3-LennardJonesNonintegrable
```json
{
  "source_id": "MD-6.1.3-LennardJonesNonintegrable",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "219",
  "pdf_page": "240",
  "statement_latex": "For example a collection of atoms on the infinite domain interacting in Lennard-Jones potentials does not satisfy the third condition, and it does not have a well defined canonical partition function.\nFor simplicity, just take the case of a one degree-of-freedom system with $H=p^2/2+q^{-12}-q^{-6}$, $q>0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.lennardJonesNonintegrable",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]精确取原一自由度例子的q>0配置权重；动量Gaussian有限因子不会修复配置尾部发散。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lennardJonesNonintegrable : ∀ β : ℝ, 0 < β →
  ¬ IntegrableOn (fun q : ℝ ↦ Real.exp (-β*(q⁻¹^12-q⁻¹^6))) (Ioi 0)
```

### MD-6.1.3-LennardJonesConfinement
```json
{
  "source_id": "MD-6.1.3-LennardJonesConfinement",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "219",
  "pdf_page": "240",
  "statement_latex": "In order to use a one-degree-of-freedom model on an infinite domain in the canonical setting, we would need to incorporate a restraining potential, slightly modifying for example the Lennard-Jones potential to $U(q)=q^{-12}-q^{-6}+\\epsilon q^2$ (Fig. 6.2).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.lennardJonesConfinement",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]ε>0；保存完整势能公式，并给出足以控制无穷尾部的二次下界；q=0处总逆元记号不替代原q>0模型，不计奇点积分已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lennardJonesConfinement : ∀ ε : ℝ, 0 < ε → ∃ C : ℝ,
  ∀ q : ℝ, ε*q^2- C ≤ q⁻¹^12-q⁻¹^6+ε*q^2
```

### MD-6.1.3-PeriodicWeightIntegrable
```json
{
  "source_id": "MD-6.1.3-PeriodicWeightIntegrable",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "218",
  "pdf_page": "239",
  "statement_latex": "If $U$ is smooth and the domain $Q$ is finite, then clearly both integrals are well defined, so the normalization is sensible.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.periodicWeightIntegrable",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinPeriodicGibbsWeight_integrable"
  ],
  "extra_assumptions": [
    "[EXTRA]独立单位质量/单位torus、光滑周期U特例；配置Haar×动量Lebesgue采用正式flatPhaseMeasure的实际定义，避免隐式不同测度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem periodicWeightIntegrable {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Integrable (textbookLangevinPeriodicGibbsWeight U β)
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)
```

### MD-6.1.3-PeriodicPartitionPositive
```json
{
  "source_id": "MD-6.1.3-PeriodicPartitionPositive",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "218",
  "pdf_page": "239",
  "statement_latex": "In order for the density in (6.3) to be normalizable, it is necessary that the quantity $Z_{\\rm can}$ ... be finite, i.e., that the integral converge.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.periodicPartitionPositive",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinCanonicalPartition_pos"
  ],
  "extra_assumptions": [
    "[EXTRA]正式库现成真实周期、单位质量、正β特例；正finite partition由已证可积性和严格正权重推出，未假设所需归一化结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem periodicPartitionPositive {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : 0 < textbookLangevinCanonicalPartition U β
```

### MD-6.1.3-MeanEnergyConstraint
```json
{
  "source_id": "MD-6.1.3-MeanEnergyConstraint",
  "kind": "definition",
  "label": null,
  "section": "6.1.3",
  "printed_page": "218",
  "pdf_page": "239",
  "statement_latex": "whereas $\\beta$ and hence the temperature arises from the choice of average energy, i.e. from solving the equation\n\\[\\frac{\\int H(z)e^{-\\beta H(z)}d\\omega}{\\int e^{-\\beta H(z)}d\\omega}=\\bar E.\\]\nAlternatively, we may take the position that the temperature is specified and the mean energy is a direct consequence of this choice.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整确定β的实际积分方程作为约束定义；不给定任意Ē就伪造β存在/唯一性，物理建模假设仍待审。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.meanEnergyConstraint",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def meanEnergyConstraint {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β meanEnergy : ℝ) : Prop :=
  (∫ z, H z * Real.exp (-β*H z) ∂ν) / (∫ z, Real.exp (-β*H z) ∂ν) = meanEnergy
```

