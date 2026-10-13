# BATCH25 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.6-EulerInvariant
```json
{
  "source_id": "MD-5.6-EulerInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "This means that with the single exception $\\rho(q,p;0)=\\delta[q]\\delta[p]$ there is no limiting (invariant) distribution for Forward Euler. To put it another way, the only solution, in the weak sense, of $\\mathcal L_{\\widetilde f}^*\\rho=0$ is the point distribution $\\delta[q]\\delta[p]$, and this solution is not “asymptotically stable.”",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.eulerInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实Forward Euler映射的不变概率测度，h≠0；一般modified微分方程的弱稳态并非自动等同离散不变测度，原记号作为解释而非未经证明的算子识别。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem eulerInvariant :
  ∀ h : ℝ, h ≠ 0 → ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),
  IsProbabilityMeasure μ → MeasurePreserving (MolecularDynamics.Chapter05Review.forwardEuler h) μ μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2
```

### MD-5.6-BackwardEuler
```json
{
  "source_id": "MD-5.6-BackwardEuler",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "As an alternative, consider the Backward Euler method: $q_{n+1}=q_n+hp_{n+1}$, $p_{n+1}=p_n-hq_{n+1}$. Then it is easily shown that both eigenvalues of the matrix lie in the interior of the unit disk, and hence all solutions of the recurrence relation tend to the origin with increasing $n$ (the origin is an attractive equilibrium point).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.backwardEuler",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]解出的实际二维线性更新，分母1+h²恒正；收缩需h≠0，h=0恒等映射不收缩。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def backwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```

### MD-5.6-BackwardEnergyDecay
```json
{
  "source_id": "MD-5.6-BackwardEnergyDecay",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "both eigenvalues of the matrix lie in the interior of the unit disk, and hence all solutions of the recurrence relation tend to the origin with increasing $n$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.backwardEnergyDecay",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实有限步平方范数代数恒等式另列；全轨道趋原点及测度弱极限另保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem backwardEnergyDecay : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 1)^2=
    (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2)
```

### MD-5.6-BackwardEulerLimit
```json
{
  "source_id": "MD-5.6-BackwardEulerLimit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "all solutions of the recurrence relation tend to the origin with increasing $n$ (the origin is an attractive equilibrium point). In this case, all densities evolve toward the Dirac distribution centered at the origin: $\\delta[q]\\delta[p]$. The only (distributional) solution of $\\mathcal L_{\\widetilde f}^*\\rho=0$ is again $\\delta[q]\\delta[p]$, which in this case is attractive.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.backwardEulerLimit",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]h≠0及实际任意初始概率测度；全轨道收缩与对每个有界连续测试函数的弱趋Dirac两个结论，非普通密度逐点收敛。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem backwardEulerLimit :
  ∀ h : ℝ,h ≠ 0 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0)) ∧
  ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun k : ℕ => ∫ z,φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) ∂μ) atTop (𝓝 (φ 0))
```

### MD-5.6-SymplecticEuler
```json
{
  "source_id": "MD-5.6-SymplecticEuler",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "Now consider the application of the Symplectic Euler method, $q_{n+1}=q_n+hp_{n+1}$, $p_{n+1}=p_n-hq_n$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.symplecticEuler",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def symplecticEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
```

### MD-5.6-SymplecticEulerShadow
```json
{
  "source_id": "MD-5.6-SymplecticEulerShadow",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "the solution through any given initial point remains confined to an ellipse for all $n$ defined by $\\widetilde H_h(q,p)=\\widetilde H_h(q_0,p_0)$, where $\\widetilde H_h$ is the perturbed Hamiltonian defined by the backward error analysis.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.symplecticEulerShadow",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]完整实际二次修正能量的一步保持恒等式；正定椭圆资格及所有n保持另条，不以一步式称全部椭圆结论已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerShadow : symplecticEulerShadow_statement
```

### MD-5.6-SymplecticEulerEllipse
```json
{
  "source_id": "MD-5.6-SymplecticEulerEllipse",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "the solution through any given initial point remains confined to an ellipse for all $n$ defined by $\\widetilde H_h(q,p)=\\widetilde H_h(q_0,p_0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.symplecticEulerEllipse",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]稳定条件|h|<2；原不加资格的椭圆说法在|h|≥2失败。本条保留正定/紧性和所有迭代保持；0能量是退化点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerEllipse : ∀ h : ℝ,|h| < 2 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 → 0 < MolecularDynamics.Chapter05Review.shadowOscillator h z) ∧
  (∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c}) ∧
  (∀ z : MolecularDynamics.Chapter05Review.E 2,∀ k : ℕ,MolecularDynamics.Chapter05Review.shadowOscillator h ((MolecularDynamics.Chapter05Review.symplecticEuler h)^[k] z)=
    MolecularDynamics.Chapter05Review.shadowOscillator h z)
```

### MD-5.6-SymplecticEulerDensity
```json
{
  "source_id": "MD-5.6-SymplecticEulerDensity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "This implies that a density which is a function of $\\widetilde H_h$ will remain invariant under the associated Liouville equation. There are many solutions of $\\mathcal L_{\\widetilde f}^*\\rho=0$, none of which is attractive.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.symplecticEulerDensity",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]真实离散映射MeasurePreserving、不变二次能量、实际概率密度r∘Htilde；完整弱Liouville稳态及非吸引另条，所有r都可归一不能自动推出。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerDensity :
  ∀ h : ℝ, |h| < 2 → ∀ r : ℝ → ℝ,
  MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h) →
    MeasurePreserving (MolecularDynamics.Chapter05Review.symplecticEuler h) (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h))
      (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h))
```

