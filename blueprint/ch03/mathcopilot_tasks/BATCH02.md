# BATCH02 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.1-AdjointEulerOscillator
```json
{
  "source_id": "MD-3.1-AdjointEulerOscillator",
  "kind": "definition",
  "label": null,
  "section": "3.1",
  "printed_page": "98",
  "pdf_page": "120",
  "statement_latex": "Let us begin with an illustrative example. Consider the harmonic oscillator with frequency $\\Omega$ which has Hamiltonian $H(q,p)=p^2/2+\\Omega^2q^2/2$, and consider the adjoint symplectic Euler method\n\\[Q=q+hp,\\qquad P=p-h\\Omega^2Q,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$q,p,Q,P,h,\\Omega\\in\\mathbb R$；$H(q,p)=(p^2+\\Omega^2q^2)/2$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.oscillatorAdjointEuler",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def oscillatorAdjointEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2
  (q,z.2-h*Ω^2*q)
```

### MD-3.1-ShadowHamiltonian
```json
{
  "source_id": "MD-3.1-ShadowHamiltonian",
  "kind": "definition",
  "label": "(3.1)",
  "section": "3.1",
  "printed_page": "98",
  "pdf_page": "120",
  "statement_latex": "However, if we modify the Hamiltonian from $H(q,p)=p^2/2+\\Omega^2q^2/2$ to\n\\[\\widetilde H(q,p)=\\frac{p^2+h\\Omega^2pq+\\Omega^2q^2}{2},\\tag{3.1}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页$Q=q+hp$、$P=p-h\\Omega^2Q$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.oscillatorShadow",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def oscillatorShadow (Ω h : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+h*Ω^2*z.2*z.1+Ω^2*z.1^2)/2
```

### MD-3.1-EnergyFailure
```json
{
  "source_id": "MD-3.1-EnergyFailure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.1",
  "printed_page": "98",
  "pdf_page": "120",
  "statement_latex": "If $H(q,p)=E$, then, for typical steps, we cannot expect $H(Q,P)=E$. (Just insert the formulas for $Q$ and $P$ into the Hamiltonian and check that the value is not the same as $H(q,p)$.)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页$H(q,p)=(p^2+\\Omega^2q^2)/2$，$Q=q+hp$、$P=p-h\\Omega^2Q$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.oscillatorEnergyFailure",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.oscillatorEnergyFailure_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem oscillatorEnergyFailure :
    ∃ Ω h : ℝ, 0 < Ω ∧ h ≠ 0 ∧ ∃ z : ℝ × ℝ,
      oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z) ≠ oscillatorEnergy Ω z
```

### MD-3.1-ShadowInvariant
```json
{
  "source_id": "MD-3.1-ShadowInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.1",
  "printed_page": "99",
  "pdf_page": "121",
  "statement_latex": "This means that $\\widetilde H$ is a conserved quantity of the numerical method.",
  "proof_latex": "\\[\\begin{aligned}\\widetilde H(Q,P)&=\\frac{P^2}{2}+\\frac{h\\Omega^2PQ}{2}+\\frac{\\Omega^2Q^2}{2}\\\\\n&=\\frac12p^2-\\frac{h\\Omega^2pQ}{2}+\\frac{\\Omega^2Q^2}{2}\\\\&=\\widetilde H(q,p).\\end{aligned}\\]",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\widetilde H$及adjoint symplectic Euler见p.98/PDF120。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.oscillatorShadowInvariant",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem oscillatorShadowInvariant :
  ∀ Ω h z, oscillatorShadow Ω h (oscillatorAdjointEuler Ω h z)=oscillatorShadow Ω h z
```

### MD-3.1-ShadowEllipses
```json
{
  "source_id": "MD-3.1-ShadowEllipses",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.1",
  "printed_page": "99",
  "pdf_page": "121",
  "statement_latex": "Recall that the graph of\n\\[\\frac{x^2}{a^2}+\\frac{y^2}{b^2}=1\\]\nis an ellipse with major and minor axes aligned to the coordinate axes. If $\\epsilon$ is a small value, then,\n\\[\\frac{x^2}{a^2}+\\frac{y^2}{b^2}+\\epsilon xy=1\\]\nwill be a slightly rotated ellipse (with slightly different major and minor axes). Thus we can think of the energy surface of the numerical method as being a small perturbation of the ellipse which represents the ‘energy surface’ (energy curve, in this case) of the harmonic oscillator itself.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$a,b\\ne0$；小扰动一般二次曲线作为背景；本条完整原文的泛型二次曲线尚需与Lean振子特例统一。",
    "$\\widetilde H$见p.98/PDF120；正能量水平集。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "一般a,b,ε椭圆旋转与振子特例之间仍需完整统一；不以特例冒充全部结论。"
    }
  ],
  "lean_decl": "MD.Ch03.shadowEllipses",
  "reusable_proofs": [],
  "extra_assumptions": [
    "显式Ω>0、|hΩ|<2，排除退化与不稳定步长；线性等价给出振子二次型标准形。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem shadowEllipses :
    (∀ a b : ℝ, a ≠ 0 → b ≠ 0 →
      ∃ δ > 0, ∃ θ A B : ℝ → ℝ,
        Tendsto A (𝓝 0) (𝓝 |a|) ∧ Tendsto B (𝓝 0) (𝓝 |b|) ∧
        (∀ ε ∈ Ioo (-δ) δ, 0 < A ε ∧ 0 < B ε ∧ ∀ x y : ℝ,
          x^2/a^2+y^2/b^2+ε*x*y =
            (Real.cos (θ ε)*x+Real.sin (θ ε)*y)^2/(A ε)^2+
            (-Real.sin (θ ε)*x+Real.cos (θ ε)*y)^2/(B ε)^2)) ∧
    (∀ Ω h : ℝ, 0 < Ω → |h*Ω| < 2 →
      (∀ z : ℝ × ℝ, z ≠ 0 → 0 < oscillatorShadow Ω h z) ∧
      ∃ L : (ℝ × ℝ) ≃ₗ[ℝ] (ℝ × ℝ), ∀ z,
        oscillatorShadow Ω h (L z)=(z.1^2+z.2^2)/2)
```

### MD-3.1-EulerGrowth
```json
{
  "source_id": "MD-3.1-EulerGrowth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.1",
  "printed_page": "100",
  "pdf_page": "122",
  "statement_latex": "Obviously this conservation property (the existence of a perturbed energy surface) is a special feature of the method we have considered. If we used Euler’s method to solve the harmonic oscillator we would find that energy grows without bound.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "振子及原始能量见p.98/PDF120；Euler为$(q+hp,p-h\\Omega^2q)$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.eulerOscillatorGrowth",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω≠0、固定h≠0且初始能量>0，排除平衡点和零步长。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem eulerOscillatorGrowth :
  ∀ Ω h : ℝ, Ω ≠ 0 → h ≠ 0 → ∀ z : ℝ × ℝ, 0 < oscillatorEnergy Ω z →
    Tendsto (fun ν : ℕ => oscillatorEnergy Ω ((oscillatorEuler Ω h)^[ν] z)) atTop atTop
```

### MD-3.1-FormalHamiltonian
```json
{
  "source_id": "MD-3.1-FormalHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "3.1",
  "printed_page": "100",
  "pdf_page": "122",
  "statement_latex": "Now consider the more general Hamiltonian setting. Let $\\mathcal G_h$ be a $r$th order symplectic integrator, $r\\ge1$. Suppose that it is the flow map of a certain Hamiltonian system, with Hamiltonian $\\widetilde H_h$. If the method order is $r$, we may expect this Hamiltonian to be a $O(h^r)$ approximation of $H$, thus we posit an expansion of the form\n\\[\\widetilde H_h=H+h^rH^{(r)}+h^{r+1}H^{(r+1)}+\\cdots.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$r\\ge1$；$H^{(j)}$为待确定光滑系数函数；h为形式变量而不是级数收敛参数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)
```

### MD-3.1-FormalHamiltonianField
```json
{
  "source_id": "MD-3.1-FormalHamiltonianField",
  "kind": "definition",
  "label": null,
  "section": "3.1",
  "printed_page": "100",
  "pdf_page": "122",
  "statement_latex": "To determine the terms $H^{(r)},H^{(r+1)},\\ldots$, we write the differential equations on $\\widetilde H_h$:\n\\[\\dot{\\boldsymbol z}=J\\nabla H+h^rJ\\nabla H^{(r)}+h^{r+1}J\\nabla H^{(r+1)}+\\cdots.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": "The solution of this system can be expanded in powers of h and equated term-by-term with the expansion of G_h in powers of h. In this way, successive terms may be computed. Although mechanical, this procedure is tedious.",
  "context_notation": [
    "$r\\ge1$；形式Hamiltonian见同页上段；每个系数取真实$J\\nabla H^{(j)}$，不把无穷级数当收敛ODE。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalHamiltonianField",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n)
    (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)
```

