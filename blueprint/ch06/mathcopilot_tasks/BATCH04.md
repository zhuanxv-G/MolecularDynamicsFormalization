# BATCH04 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.1.3-EntropyFunctional
```json
{
  "source_id": "MD-6.1.3-EntropyFunctional",
  "kind": "definition",
  "label": null,
  "section": "6.1.3",
  "printed_page": "217",
  "pdf_page": "238",
  "statement_latex": "density is as a stationary point of the Gibbs-Boltzmann entropy\n\\[S=-k_B\\int\\rho\\ln\\rho\\,d\\omega,\\]\nsubject to the constraints $\\int\\rho(z)d\\omega=1$, $\\int H(z)\\rho(z)d\\omega=\\bar E$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Bochner积分；约束不是熵定义的自动结论，ConstrainedEntropyModel保存两个约束；0log0总定义不计熵可积性证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.entropyFunctional",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def entropyFunctional {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (kB : ℝ) (ρ : D → ℝ) : ℝ := -kB * ∫ x, ρ x * Real.log (ρ x) ∂ν
```

### MD-6.1.3-ConstrainedEntropyModel
```json
{
  "source_id": "MD-6.1.3-ConstrainedEntropyModel",
  "kind": "definition",
  "label": null,
  "section": "6.1.3",
  "printed_page": "217",
  "pdf_page": "238",
  "statement_latex": "Using the method of Lagrange multipliers, we seek stationary solutions of\n\\[V=S/k_B-\\lambda\\left[\\int\\rho(z)d\\omega-1\\right]-\\beta\\left[\\int H(z)\\rho(z)d\\omega-\\bar E\\right]\\]\nwith respect to the choice of density $\\rho$ and coefficients $\\lambda$ and $\\beta$. The resulting equations for the maximizing density are obtained by variational differentiation:\n\\[\\frac{\\delta V}{\\delta\\rho}=0,\\quad\\int\\rho(z)d\\omega=1,\\quad\\int H(z)\\rho(z)d\\omega=\\bar E.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整常数项和两个约束保留；实际变分导数/驻点结论另见EntropyFirstVariation与EntropyVariation；kB≠0才按原物理解释约去。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.constrainedEntropyModel",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def constrainedEntropyModel {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H ρ : D → ℝ) (kB lambdaParam β meanEnergy : ℝ) : ℝ × Prop :=
  (MolecularDynamics.Chapter06Review.entropyFunctional ν kB ρ / kB -
    lambdaParam * ((∫ x, ρ x ∂ν)-1) - β * ((∫ x, H x * ρ x ∂ν)-meanEnergy),
    (∫ x, ρ x ∂ν) = 1 ∧ (∫ x, H x * ρ x ∂ν) = meanEnergy)
```

### MD-6.1.3-EntropyFirstVariation
```json
{
  "source_id": "MD-6.1.3-EntropyFirstVariation",
  "kind": "extra_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "217–218",
  "pdf_page": "238–239",
  "statement_latex": "The first equation reduces to\n\\[-(1+\\ln\\rho)-\\lambda-\\beta H=0\\]\nyielding $\\rho=e^{-1-\\lambda}e^{-\\beta H}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.entropyFirstVariation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际正连续密度、可积熵/能量及光滑紧支变分；保存对V的实际HasDerivAt积分表达式，不把Euler–Lagrange结论作前提。",
    "[EXTRA]省略与ρ无关的λ+βĒ常数不影响本条导数；完整含常数V另见ConstrainedEntropyModel。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem entropyFirstVariation :
  ∀ {n : ℕ} (H ρ : MolecularDynamics.Chapter06Review.V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  ∀ ψ : MolecularDynamics.Chapter06Review.V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    HasDerivAt (fun e ↦ MolecularDynamics.Chapter06Review.entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β)
      (∫ x, (-(1+Real.log (ρ x))-lambdaParam-β*H x)*ψ x) 0
```

### MD-6.1.3-EntropyVariation
```json
{
  "source_id": "MD-6.1.3-EntropyVariation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "217–218",
  "pdf_page": "238–239",
  "statement_latex": "The first equation reduces to\n\\[-(1+\\ln\\rho)-\\lambda-\\beta H=0\\]\nyielding\n\\[\\rho=e^{-1-\\lambda}e^{-\\beta H}.\\]\nThe normalization condition determines the parameter $\\lambda$, whereas $\\beta$ and hence the temperature arises from the choice of average energy.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.entropyVariation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]在每个光滑紧支实际密度方向的内点局部极值、正连续可积密度；不假设变分导数零或点态EL结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem entropyVariation :
  ∀ {n : ℕ} (H ρ : MolecularDynamics.Chapter06Review.V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  (∀ ψ : MolecularDynamics.Chapter06Review.V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    IsLocalMax (fun e ↦ MolecularDynamics.Chapter06Review.entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β) 0) →
  ∀ x, -(1+Real.log (ρ x))-lambdaParam-β*H x=0 ∧
    ρ x=Real.exp (-1-lambdaParam)*Real.exp (-β*H x)
```

### MD-6.1.3-CanonicalDensity
```json
{
  "source_id": "MD-6.1.3-CanonicalDensity",
  "kind": "definition",
  "label": "(6.3)",
  "section": "6.1.3",
  "printed_page": "218",
  "pdf_page": "239",
  "statement_latex": "This defines the phase space density of the canonical ensemble which we refer to as the Gibbs-Boltzmann density:\n\\[\\rho_\\beta=Z_{\\rm can}^{-1}e^{-\\beta H(q,p)}.\\tag{6.3}\\]\nwhere the parameter $\\beta=1/(k_BT)$. The quantity $Z_{\\rm can}$ is a normalizing constant so that this is a probability density.\n\\[Z_{\\rm can}=\\int_D e^{-\\beta H(q,p)}d\\omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际积分分母，没有独立给定Z；正有限可积条件下才为概率密度，归一化定理另列；NVT为固定N,V,T记号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.canonicalDensity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def canonicalDensity {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ) (x : D) : ℝ := Real.exp (-β * H x) / (∫ z, Real.exp (-β * H z) ∂ν)
```

### MD-6.1.3-MassHamiltonian
```json
{
  "source_id": "MD-6.1.3-MassHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "6.1.3",
  "printed_page": "218",
  "pdf_page": "239",
  "statement_latex": "If we have a standard molecular Hamiltonian $H(q,p)=p^TM^{-1}p/2+U(q)$ with $N_c=Nd$ degrees of freedom",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "M为正对角质量矩阵，m_i>0；本条保留每坐标m_i，不以单位质量代替。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.massHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def massHamiltonian {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (x : MolecularDynamics.Chapter06Review.Phase n) : ℝ :=
  (∑ i, (x.2 i) ^ 2 / (2 * m i)) + U x.1
```

### MD-6.1.3-PartitionMass
```json
{
  "source_id": "MD-6.1.3-PartitionMass",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "218",
  "pdf_page": "239",
  "statement_latex": "then the integral separates\n\\[Z_{\\rm can}=\\int_D e^{-\\beta H(q,p)}d\\omega\n=\\int_{\\mathbb R^{N_c}}e^{-\\beta p^TM^{-1}p/2}d\\omega_p\\times\\int_Q e^{-\\beta U(q)}d\\omega_q.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.partitionMass",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]此条取Q=全配置实空间；正β、任意正对角质量和配置权重可积；一般Q用下一条独立保存。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem partitionMass :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n, Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) =
    (∫ q, Real.exp (-β*U q)) * ∏ i, Real.sqrt (2*Real.pi*m i/β)
```

### MD-6.1.3-PartitionDomain
```json
{
  "source_id": "MD-6.1.3-PartitionDomain",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.3",
  "printed_page": "218",
  "pdf_page": "239",
  "statement_latex": "where $Q$ is the accessible position domain, $d\\omega_p=dp_1dp_2\\cdots dp_{N_c}$ and $d\\omega_q=dq_1dq_2\\cdots dq_{N_c}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.partitionDomain",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]配置测度μ为sigma-finite，原Q对应μ=volume.restrict Q；真实乘积测度及一般正质量，不将有限域换为torus。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem partitionDomain : ∀ {n : ℕ}
    (μ : Measure (MolecularDynamics.Chapter06Review.V n)) [SigmaFinite μ]
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) μ →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)
    ∂μ.prod (volume : Measure (MolecularDynamics.Chapter06Review.V n))) =
  (∫ q, Real.exp (-β*U q) ∂μ) * ∏ i, Real.sqrt (2*Real.pi*m i/β)
```

