# BATCH19 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3.2-OUProcess
```json
{
  "source_id": "MD-6.3.2-OUProcess",
  "kind": "definition",
  "label": "(6.19)",
  "section": "6.3.2",
  "printed_page": "234",
  "pdf_page": "255",
  "statement_latex": "For now we will examine the special case of a scalar equation\n\\[dX=-\\gamma Xdt+\\sigma dW;\\tag{6.19}\\]\nwhere $\\gamma>0$ and $\\sigma$ are constants. We term Eq. (6.19) the Ornstein-Uhlenbeck SDE.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.strictOUProcess",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原显式γ>0保留在真实严格L²积分方程的资格中，不将分布式解作方程前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def strictOUProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 : ℝ) : Prop :=
  0 < γ ∧ strictScalarSDE P W X (fun x _ ↦ -γ*x) (fun _ _ ↦ σ) x0
```

### MD-6.3.2-OUIntegratingFactor
```json
{
  "source_id": "MD-6.3.2-OUIntegratingFactor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.2",
  "printed_page": "234",
  "pdf_page": "255",
  "statement_latex": "Multiply both sides of (6.19) by the integrating factor $\\exp(\\gamma t)$, and observe that\n\\[d(\\exp(\\gamma t)X)=\\exp(\\gamma t)(dX+\\gamma Xdt);\\]\nthus (6.19) becomes\n\\[d(\\exp(\\gamma t)X)=\\sigma\\exp(\\gamma t)dW(t).\\]\nWe then integrate both sides to obtain\n\\[\\exp(\\gamma t)X(t)=X(0)+\\sigma\\int_0^t\\exp(\\gamma s)dW(s).\\]\nMultiplying by $e^{-\\gamma t}$ gives\n\\[X(t)=e^{-\\gamma t}X(0)+\\sigma e^{-\\gamma t}\\int_0^t\\exp(\\gamma s)dW(s).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.ouIntegratingFactor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际PreBrownian、严格OU与严格确定性Ito积分见证、γ>0和t≥0；完整求值，不以解公式作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem ouIntegratingFactor :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  ∃ Y : Ω → ℝ, strictItoIntegral P W (fun s _ ↦ Real.exp (γ*s)) T Y ∧
    ∀ᵐ sample ∂P, X T sample = Real.exp (-γ*T)*x0 + σ*Real.exp (-γ*T)*Y sample
```

### MD-6.3.2-OUVarianceIntegral
```json
{
  "source_id": "MD-6.3.2-OUVarianceIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.2",
  "printed_page": "235",
  "pdf_page": "256",
  "statement_latex": "Using Proposition 6.3, we know that for a Wiener process $W(t)$, $Y(t)\\stackrel{\\rm def}=\\int_0^t\\exp(\\gamma s)dW(s)$ is a Gaussian random variable with mean zero and variance\n\\[\\operatorname{Var}\\{Y(t)\\}=\\int_0^t e^{2\\gamma s}ds=\\frac{e^{2\\gamma t}-1}{2\\gamma}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.ouVarianceIntegral",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]γ>0使分母非零；随机变量完整Gaussian law在Prop6.3和OULawCorrect保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem ouVarianceIntegral : ∀ (γ T : ℝ), 0 < γ → 0 ≤ T →
  (∫ s in (0 : ℝ)..T, Real.exp (2*γ*s))=(Real.exp (2*γ*T)-1)/(2*γ)
```

### MD-6.3.2-OULawPrinted
```json
{
  "source_id": "MD-6.3.2-OULawPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.2",
  "printed_page": "235",
  "pdf_page": "256",
  "statement_latex": "The solution with equivalent distribution is therefore\n\\[X(t)=e^{-\\gamma t}X(0)+\\sigma\\sqrt{(2\\gamma)^{-1}}(1-e^{-2\\gamma t})\\widehat Y(t).\\]\nwhere $\\widehat Y(t)$ should be interpreted as random process which at every time $t$ evaluates to a normal random variable ($\\widehat Y(t)\\sim N(0,1)$). This is what we mean by the exact distributional solution of the Ornstein-Uhlenbeck SDE with prescribed initial value $X(0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原页根号只覆盖(2γ)⁻¹，(1−e⁻²γt)漏在根号内；方差因此被错误平方。单时分布等价不确定整个过程耦合。"
    }
  ],
  "lean_decl": "MD.Ch06.ouLawPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem ouLawPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 →
  0 < γ → 0 ≤ T → HasLaw (X T)
    (gaussianReal (Real.exp (-γ*T)*x0)
      ((σ*Real.sqrt ((2*γ)⁻¹)*(1-Real.exp (-2*γ*T)))^2).toNNReal) P
```

### MD-6.3.2-OULawCorrect
```json
{
  "source_id": "MD-6.3.2-OULawCorrect",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.2",
  "printed_page": "235",
  "pdf_page": "256",
  "statement_latex": "The solution with equivalent distribution is therefore\n\\[X(t)=e^{-\\gamma t}X(0)+\\sigma\\sqrt{(2\\gamma)^{-1}}(1-e^{-2\\gamma t})\\widehat Y(t).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.ouLawCorrect",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]修正标准差σ√((1−e⁻²γt)/(2γ))，完整真实单时Gaussian法则；均值e⁻γtx0、方差σ²(1−e⁻²γt)/(2γ)，不预置law结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem ouLawCorrect :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 T) (MolecularDynamics.Chapter06Review.ouVariance γ σ T).toNNReal) P
```

### MD-6.3.2-OUGibbsLimit
```json
{
  "source_id": "MD-6.3.2-OUGibbsLimit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.2",
  "printed_page": "235",
  "pdf_page": "256",
  "statement_latex": "Let $\\sigma=\\sqrt{2\\gamma k_BT m}$; then for large $t$ the exponentials of the form $e^{-\\gamma t}$ tend to zero, and we have\n\\[X(t)\\approx\\sqrt{k_BT m}\\widehat Y(t);\\]\n in which case $X(t)$ is drawn from the probability density\n\\[\\rho_\\infty(u)=\\frac1{\\sqrt{2\\pi m k_BT}}\\exp\\left(-\\frac1{k_BT}\\frac{u^2}{2m}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.ouGibbsLimit",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]θ=kBT>0,m>0,γ>0；完整弱收敛，全部有界连续检验函数；不只证明均值/方差参数极限。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem ouGibbsLimit :
  ∀ (γ θ m x0 : ℝ), 0 < γ → 0 < θ → 0 < m →
  ∀ f : ℝ → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ x, f x ∂gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 t)
      (MolecularDynamics.Chapter06Review.ouVariance γ (Real.sqrt (2*γ*θ*m)) t).toNNReal) atTop
      (𝓝 (∫ x, f x ∂gaussianReal 0 (θ*m).toNNReal))
```

### MD-6.3.2-MomentumOU
```json
{
  "source_id": "MD-6.3.2-MomentumOU",
  "kind": "definition",
  "label": "(6.20)–(6.21)",
  "section": "6.3.2",
  "printed_page": "235",
  "pdf_page": "256",
  "statement_latex": "For a system with $N_c$ configurational variables we may write\n\\[dp_i=-\\gamma p_i dt+\\sqrt{2\\gamma k_BT m_i}\\,dW_i;\\tag{6.20}\\]\nwhere $W_1(t),W_2(t),\\ldots,W_{N_c}(t)$ represent $N_c$ independent Wiener processes, or, in vectorial notation, denoting $W=[W_1,W_2,\\ldots,W_{N_c}]^T$, we have\n\\[dp=-\\gamma pdt+\\sqrt{2\\gamma k_BT}M^{1/2}dW.\\tag{6.21}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.momentumOU",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]全部正对角质量mi、γ>0、θ=kBT>0和真实各坐标严格积分关系；独立多维W资格另给，不把单位质量桥接当一般质量已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def momentumOU {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W p : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (γ θ : ℝ) (p0 : MolecularDynamics.Chapter06Review.V n) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧
  ∀ i, strictOUProcess P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i) γ (Real.sqrt (2*γ*θ*m i)) (p0 i)
```

### MD-6.3.2-GibbsGaussianDensity
```json
{
  "source_id": "MD-6.3.2-GibbsGaussianDensity",
  "kind": "definition",
  "label": null,
  "section": "6.3.2",
  "printed_page": "235",
  "pdf_page": "256",
  "statement_latex": "in which case $X(t)$ is drawn from the probability density\n\\[\\rho_\\infty(u)=\\frac1{\\sqrt{2\\pi m k_BT}}\\exp\\left(-\\frac1{k_BT}\\frac{u^2}{2m}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "θ=kBT>0,m>0；原规范化密度实际公式，仅定义不计积分归一化已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.gibbsGaussianDensity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def gibbsGaussianDensity (θ m u : ℝ) : ℝ :=
  Real.exp (-(u^2/(2*m))/θ)/Real.sqrt (2*Real.pi*m*θ)
```

