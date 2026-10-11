# BATCH03 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.1-PrintedImplicitRelation
```json
{
  "source_id": "MD-4.1-PrintedImplicitRelation",
  "kind": "definition",
  "label": null,
  "section": "4.1",
  "printed_page": "142",
  "pdf_page": "164",
  "statement_latex": "The Implicit Midpoint method, for the ODE $\\dot z=f(z)$ takes the form\n\\[z_{n+1}=z_n+h\\frac{f(z_n)+f(z_{n+1})}{2},\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p142名为Implicit Midpoint却写Trapezoidal Rule更新式；p144采用真正机械中点式。"
    }
  ],
  "lean_decl": "MD.Ch04.printedImplicitRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def printedImplicitRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)
```

### MD-4.1-ActualMidpointRelation
```json
{
  "source_id": "MD-4.1-ActualMidpointRelation",
  "kind": "definition",
  "label": null,
  "section": "4.1",
  "printed_page": "142",
  "pdf_page": "164",
  "statement_latex": "The Implicit Midpoint method, for the ODE $\\dot z=f(z)$",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.actualMidpointRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]名称通常对应的真正中点关系Z=z+h f((z+Z)/2)供审校上下文；不是原页的印刷公式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def actualMidpointRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+h • f ((1/2 : ℝ) • (z+znew))
```

### MD-4.1-ImplicitFactor
```json
{
  "source_id": "MD-4.1-ImplicitFactor",
  "kind": "definition",
  "label": null,
  "section": "4.1",
  "printed_page": "142",
  "pdf_page": "164",
  "statement_latex": "can be applied to $\\dot z=i\\Omega z$ and yields\n\\[z_{n+1}=\\frac{1+ih\\Omega/2}{1-ih\\Omega/2}z_n.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "线性场中点/梯形相同；Ω,h实数，分母实部1永不为0。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.implicitFactor",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))
```

### MD-4.1-ImplicitModulus
```json
{
  "source_id": "MD-4.1-ImplicitModulus",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.1",
  "printed_page": "142",
  "pdf_page": "164",
  "statement_latex": "For all real $\\Omega$, we find\n\\[\\left|\\frac{1+ih\\Omega/2}{1-ih\\Omega/2}\\right|=1.\\]\nThis indicates that the Implicit Midpoint method has no stability threshold for the stepsize when solving a linear system!",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.implicitModulus",
  "reusable_proofs": [],
  "extra_assumptions": [
    "只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem implicitModulus :
  ∀ Ω h : ℝ, ‖MolecularDynamics.Chapter04Review.implicitFactor Ω h‖=1
```

### MD-4.1-PrintedModifiedFrequency
```json
{
  "source_id": "MD-4.1-PrintedModifiedFrequency",
  "kind": "definition",
  "label": null,
  "section": "4.1",
  "printed_page": "143",
  "pdf_page": "165",
  "statement_latex": "If the Implicit Midpoint method is viewed as the exact solution of a perturbed harmonic oscillator, then the frequency of this oscillator is\n\\[\\widehat\\Omega=\\frac1{ih}\\ln\\frac{1+ih\\Omega/2}{1-ih\\Omega/2}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "原书未指定复log分支；与连续实相位的桥接须审校。"
    }
  ],
  "lean_decl": "MD.Ch04.printedModifiedFrequency",
  "reusable_proofs": [],
  "extra_assumptions": [
    "h≠0；采用Mathlib Complex.log主支，对原未指定log支单独记录；后条连续实相位为2 atan(hΩ/2)/h。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def printedModifiedFrequency (Ω h : ℝ) : ℂ :=
  (Complex.I*(h : ℂ))⁻¹ * Complex.log (MolecularDynamics.Chapter04Review.implicitFactor Ω h)
```

### MD-4.1-ModifiedFrequencyLimit
```json
{
  "source_id": "MD-4.1-ModifiedFrequencyLimit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.1",
  "printed_page": "143",
  "pdf_page": "165",
  "statement_latex": "The figure shows that the frequency is only well approximated in case $h\\Omega$ is sufficiently small. For $h\\Omega\\gg1$ the frequency is highly modified.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "printedModifiedFrequency复log支对应需另审；本条采用实连续相位。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.modifiedFrequencyLimit",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem modifiedFrequencyLimit :
  ∀ Ω : ℝ, Tendsto (MolecularDynamics.Chapter04Review.modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω)
```

### MD-4.1-MechanicalMidpoint
```json
{
  "source_id": "MD-4.1-MechanicalMidpoint",
  "kind": "definition",
  "label": null,
  "section": "4.1",
  "printed_page": "144",
  "pdf_page": "166",
  "statement_latex": "we may reduce the equations to determining midpoint values $\\widehat q,\\widehat p$ such that\n\\[\\widehat q=q_n+\\frac h2M^{-1}\\widehat p,\\qquad\\widehat p=p_n-\\frac h2\\nabla U(\\widehat q),\\]\nwhere, then,\n\\[q_{n+1}=\\widehat q+\\frac h2M^{-1}\\widehat p,\\qquad p_{n+1}=\\widehat p-\\frac h2\\nabla U(\\widehat q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留四个真实关系，不假装隐式解存在唯一；质量正是物理资格。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.mechanicalMidpointRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (h : ℝ) (z mid out : MolecularDynamics.Chapter04Review.Z n) : Prop :=
  mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ mid.2=z.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1 ∧
  out.1=mid.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ out.2=mid.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1
```

### MD-4.1-MidpointElimination
```json
{
  "source_id": "MD-4.1-MidpointElimination",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.1",
  "printed_page": "144",
  "pdf_page": "166",
  "statement_latex": "We may therefore view the step as a composition of Implicit Euler and Explicit Euler half-steps. Eliminating $\\widehat p$, we find\n\\[\\widehat q=q_n+\\frac h2M^{-1}p_n-\\frac{h^2}{4}M^{-1}\\nabla U(\\widehat q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际四关系推出位置消元等式；不增加解存在或Newton收敛结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.midpointElimination",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem midpointElimination :
  ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) h (z mid out : MolecularDynamics.Chapter04Review.Z n),
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out →
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m z.2-(h^2/4) • MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad U mid.1)
```

