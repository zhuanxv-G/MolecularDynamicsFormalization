# BATCH24 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.6-DiscreteAveragePrinted
```json
{
  "source_id": "MD-5.6-DiscreteAveragePrinted",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "If $z_n$ represents the approximation to $z(t_n)$, then we might attempt to estimate $\\bar g$ by\n\\[\\bar g\\approx\\lim_{n\\to\\infty}n^{-1}\\sum_{k=0}^ng(z_k).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原式包含n+1项却除n，字面有限和保留；无限极限并非对所有算法/所有轨道存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.discreteAveragePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def discreteAveragePrinted {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range (N+1),g (G^[k] z)
```

### MD-5.6-DiscreteAverage
```json
{
  "source_id": "MD-5.6-DiscreteAverage",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "$\\bar g\\approx\\lim_{n\\to\\infty}n^{-1}\\sum_{k=0}^ng(z_k)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.discreteAverage",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]标准n项平均修正版，另列不覆盖原n+1项；n=0总化除法不赋予统计平均意义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def discreteAverage {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range N,g (G^[k] z)
```

### MD-5.6-DiscretePropagator
```json
{
  "source_id": "MD-5.6-DiscretePropagator",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "In a similar way, a numerical method $z_{n+1}=F_h(z_n)$ induces an effective distributional propagator.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Measure.map迭代映射；不把有限modified equation宣称算法的精确全时流。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.discretePropagator",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def discretePropagator {X : Type*} [MeasurableSpace X] (G : X → X) (μ : Measure X) := Measure.map G μ
```

### MD-5.6-ModifiedField
```json
{
  "source_id": "MD-5.6-ModifiedField",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "One way to understand this propagator is to interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation\n\\[\\frac{dz}{dt}=f(z)+h^rf^{(r)}(z)=\\widetilde f_h(z).\\]\nThe perturbation term may be viewed as the finite truncation of the perturbative expansion obtained from the backward error analysis using the methods of the previous chapter. ($r$ is the order of the numerical method.)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际有限截断向量场；近似与余项受控未由定义推出，不假设形式展开收敛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.modifiedField",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def modifiedField {n : ℕ} (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z
```

### MD-5.6-ModifiedLiouvillian
```json
{
  "source_id": "MD-5.6-ModifiedLiouvillian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "Let us assume that the perturbed equation is a realistic model for the numerical solutions, then define the evolving density by\n\\[\\frac{\\partial\\rho}{\\partial t}=\\mathcal L_{\\widetilde f}^{*}\\rho\n\\stackrel{\\rm def}{=}\\mathcal L_f^*\\rho+h^r\\mathcal L_{f^{(r)}}^*\\rho.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.modifiedLiouvillian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Fréchet导数和trace，可微f/fr/u资格；只证微分表达式对场线性，不声称余项密度误差已受控。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem modifiedLiouvillian :
  ∀ n (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) h r,
  Differentiable ℝ f → Differentiable ℝ fr → Differentiable ℝ u → ∀ z,
  MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=MolecularDynamics.Chapter05Review.liouvillian f u z+h^r*MolecularDynamics.Chapter05Review.liouvillian fr u z
```

### MD-5.6-ForwardEuler
```json
{
  "source_id": "MD-5.6-ForwardEuler",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "206–207",
  "pdf_page": "227–228",
  "statement_latex": "Applying Forward Euler to the harmonic oscillator, we have\n\\[q_{n+1}=q_n+hp_n,\\qquad p_{n+1}=p_n-hq_n,\\]\nor $\\binom{q_{n+1}}{p_{n+1}}=\\begin{pmatrix}1&h\\\\-h&1\\end{pmatrix}\\binom{q_n}{p_n}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "单位频率真实二维振子映射，不恢复其他章节长证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.forwardEuler",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def forwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
```

### MD-5.6-ForwardComponentsPrinted
```json
{
  "source_id": "MD-5.6-ForwardComponentsPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "we see that the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $(q_0,p_0)=(0,0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.forwardComponentsPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]h非零、非原点初值；“趋无穷”按绝对值解释仍有反例。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem forwardComponentsPrinted : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => |(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z 0|) atTop atTop ∧
  Tendsto (fun k : ℕ => |(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z 1|) atTop atTop
```

### MD-5.6-ForwardEnergyGrowth
```json
{
  "source_id": "MD-5.6-ForwardEnergyGrowth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "the eigenvalues of the propagation matrix are outside the unit disk.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.forwardEnergyGrowth",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际有限步能量增长恒等式，作为原谱外扩的直接代数后果另列；本式允许h=0，渐近发散需h≠0和非原点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem forwardEnergyGrowth : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 1)^2=
    (1+h^2)^k*((z 0)^2+(z 1)^2)
```

