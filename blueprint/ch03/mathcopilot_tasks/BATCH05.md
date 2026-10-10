# BATCH05 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.3-HamiltonianLieAdditivity
```json
{
  "source_id": "MD-3.3-HamiltonianLieAdditivity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "103",
  "pdf_page": "125",
  "statement_latex": "As the relation\n\\[\\mathcal L_H\\phi=\\{\\phi,H\\},\\]\nis linear in $H$, we may write, for Hamiltonians $H_1,H_2$,\n\\[\\mathcal L_{H_1+H_2}=\\mathcal L_{H_1}+\\mathcal L_{H_2}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "对任意观测量F的算子相等；$\\mathcal L_H$记号见p.102/PDF124。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianLieAdditivity",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianLieDerivative_add"
  ],
  "extra_assumptions": [
    "H₁,H₂在z可微；原文smooth资格显式化。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianLieAdditivity (F H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hH₁ : DifferentiableAt ℝ H₁ z)
    (hH₂ : DifferentiableAt ℝ H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x)) F z =
      textbookLieDerivative (textbookHamiltonianVectorField H₁) F z +
      textbookLieDerivative (textbookHamiltonianVectorField H₂) F z
```

### MD-3.3-FormalSplitting
```json
{
  "source_id": "MD-3.3-FormalSplitting",
  "kind": "definition",
  "label": null,
  "section": "3.3",
  "printed_page": "103",
  "pdf_page": "125",
  "statement_latex": "The flow map of the system with Hamiltonian $H=H_1+H_2$ is\n\\[\\mathcal F_t=e^{t(\\mathcal L_{H_1}+\\mathcal L_{H_2})}.\\]\nOn the other hand, the splitting method based on a composition of flows on $H_1$ and $H_2$ is\n\\[\\mathcal G_h=e^{h\\mathcal L_{H_1}}e^{h\\mathcal L_{H_2}}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A,B分别表示$\\mathcal L_{H_1},\\mathcal L_{H_2}$；形式指数，不能由此假设实际级数收敛。",
    "状态映射与观测量pullback组合顺序相反；实际Hamiltonian匹配条目另待审。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalSplitting",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def formalSplitting {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential A * textbookFormalOperatorExponential B
```

### MD-3.3-ExactExponentialCubic
```json
{
  "source_id": "MD-3.3-ExactExponentialCubic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "103",
  "pdf_page": "125",
  "statement_latex": "Expanding these out using the exponential series we have\n\\[\\begin{aligned}e^{h(A+B)}&=\\mathrm{Id}+h(A+B)+\\frac{h^2}{2}(A+B)^2+\\frac{h^3}{6}(A+B)^3+O(h^4)\\\\\n&=\\mathrm{Id}+h(A+B)+\\frac{h^2}{2}(AB+BA+A^2+B^2)\\\\\n&\\quad+\\frac{h^3}{6}(A^3+A^2B+AB^2+ABA+B^2A+BA^2+BAB+B^3)+O(h^4).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$R$为任意实结合环代数；不添加AB=BA；$O(h^4)$按形式系数次数≥4解释，不宣称实际范数余项。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.exactExponentialCubic",
  "reusable_proofs": [
    "MolecularDynamics.textbookFormalOperatorExponential_coeff"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem exactExponentialCubic (A B : R) :
    (∀ j < 4, PowerSeries.coeff j (textbookFormalOperatorExponential (A+B)) =
      (1/(j.factorial : ℝ)) • (A+B)^j) ∧
    ((A+B)^2 = A*B+B*A+A^2+B^2) ∧
    ((A+B)^3 = A^3+A^2*B+A*B^2+A*B*A+B^2*A+B*A^2+B*A*B+B^3)
```

### MD-3.3-ProductExponentialCubic
```json
{
  "source_id": "MD-3.3-ProductExponentialCubic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "104",
  "pdf_page": "126",
  "statement_latex": "whereas,\n\\[\\begin{aligned}e^{hA}e^{hB}&=(\\mathrm{Id}+hA+\\frac{h^2A^2}{2}+\\frac{h^3A^3}{6}+O(h^4))\\times(\\mathrm{Id}+hB+\\frac{h^2B^2}{2}+\\frac{h^3B^3}{6}+O(h^4))\\\\\n&=\\mathrm{Id}+h(A+B)+\\frac{h^2}{2}(2AB+A^2+B^2)+\\frac{h^3}{6}(A^3+B^3+3AB^2+3A^2B)+O(h^4).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "形式Cauchy乘积；保持AB的次序，两个多项式写法经分配律等价；O(h⁴)为高次系数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.productExponentialCubic",
  "reusable_proofs": [
    "MolecularDynamics.textbookFormalOperatorProduct_coeff_zero",
    "MolecularDynamics.textbookFormalOperatorProduct_coeff_one",
    "MolecularDynamics.textbookFormalOperatorProduct_coeff_two",
    "MolecularDynamics.textbookFormalOperatorProduct_coeff_three"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem productExponentialCubic (A B : R) :
    PowerSeries.coeff 0 (formalSplitting A B)=1 ∧
    PowerSeries.coeff 1 (formalSplitting A B)=A+B ∧
    PowerSeries.coeff 2 (formalSplitting A B)=
      (1/2:ℝ) • A^2+A*B+(1/2:ℝ) • B^2 ∧
    PowerSeries.coeff 3 (formalSplitting A B)=
      (1/6:ℝ) • A^3+(1/2:ℝ) • (A^2*B)+(1/2:ℝ) • (A*B^2)+(1/6:ℝ) • B^3
```

### MD-3.3-DifferenceCommutator
```json
{
  "source_id": "MD-3.3-DifferenceCommutator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "104",
  "pdf_page": "126",
  "statement_latex": "So the difference is\n\\[e^{hA}e^{hB}-e^{h(A+B)}=\\frac{h^2}{2}[A,B]+O(h^3),\\]\nwhere $[A,B]=AB-BA$ is the commutator of $A$ and $B$.\nFor a splitting method, we have, replacing $A$ by $\\mathcal L_{H_1}$ and $B$ by $\\mathcal L_{H_2}$,\n\\[e^{h\\mathcal L_{H_1}}e^{h\\mathcal L_{H_2}}-e^{h\\mathcal L_H}=\\frac{h^2}{2}[\\mathcal L_{H_1},\\mathcal L_{H_2}]+O(h^3).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$[A,B]=AB-BA$定义合并旧CH03-032；Hamiltonian算子是同一形式代数恒等式的实例；H=H₁+H₂及Lie加法见p.103/PDF125。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.differenceCommutator",
  "reusable_proofs": [
    "MolecularDynamics.textbookFormalOperatorDifference_coeff_two"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem differenceCommutator (A B : R) :
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 2 : ℝ) • (A * B - B * A)
```

### MD-3.3-DifferenceCubic
```json
{
  "source_id": "MD-3.3-DifferenceCubic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "104",
  "pdf_page": "126",
  "statement_latex": "\\[e^{hA}e^{hB}-e^{h(A+B)}=\\frac{h^2}{2}(AB-BA)+\\frac{h^3}{6}(2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)+O(h^4).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页差值展示式的三次系数；二次系数见DifferenceCommutator，不省略整个差式的另一子句。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.differenceCubic",
  "reusable_proofs": [
    "MolecularDynamics.textbookFormalOperatorDifference_coeff_three"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem differenceCubic (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A)
```

### MD-3.3-HamiltonianCommutator
```json
{
  "source_id": "MD-3.3-HamiltonianCommutator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "104–105",
  "pdf_page": "126–127",
  "statement_latex": "Observe that, for any real-valued functions $f$ and $H$ of phase space,\n\\[\\mathcal L_Hf=\\nabla f^TJ\\nabla H=\\{f,H\\}.\\]\nHence $\\mathcal L_{H_1}\\mathcal L_{H_2}f=\\{\\{f,H_2\\},H_1\\}$, and, using this and skew-symmetry of the Poisson bracket,\n\\[[\\mathcal L_{H_1},\\mathcal L_{H_2}]f=\\{\\{f,H_2\\},H_1\\}-\\{\\{f,H_1\\},H_2\\}=\\{\\{f,H_2\\},H_1\\}+\\{\\{H_1,f\\},H_2\\}.\\]\nBy the Jacobi identity, $\\{\\{f,H_2\\},H_1\\}+\\{\\{H_2,H_1\\},f\\}+\\{\\{H_1,f\\},H_2\\}=0$.\nTherefore\n\\[[\\mathcal L_{H_1},\\mathcal L_{H_2}]f=-\\{\\{H_2,H_1\\},f\\}=\\{f,\\{H_2,H_1\\}\\}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$[A,B]=AB-BA$；$\\mathcal L_Hf=\\{f,H\\}$；本条保留原书第一推导正确的$\\{H_2,H_1\\}$顺序。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianCommutator",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianLieDerivative_commutator"
  ],
  "extra_assumptions": [
    "F,H₁,H₂在z为C²；原文smooth资格显式化。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianCommutator
    (F H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiffAt ℝ 2 F z) (hH₁ : ContDiffAt ℝ 2 H₁ z)
    (hH₂ : ContDiffAt ℝ 2 H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField H₁)
        (textbookLieDerivative (textbookHamiltonianVectorField H₂) F) z -
      textbookLieDerivative (textbookHamiltonianVectorField H₂)
        (textbookLieDerivative (textbookHamiltonianVectorField H₁) F) z =
      textbookLieDerivative (textbookHamiltonianVectorField
        (textbookPoissonBracket H₂ H₁)) F z
```

### MD-3.3-HamiltonianCommutatorPrinted
```json
{
  "source_id": "MD-3.3-HamiltonianCommutatorPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "105",
  "pdf_page": "127",
  "statement_latex": "This means that it is possible to relate the commutator of Lie derivatives of Hamiltonian vector fields to the Lie derivative of the Poisson bracket of the corresponding Hamiltonians, i.e.,\n\\[[\\mathcal L_{H_1},\\mathcal L_{H_2}]f=\\mathcal L_{\\{H_1,H_2\\}}f.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本页上一式为$\\{f,\\{H_2,H_1\\}\\}$；定义$\\mathcal L_Hf=\\{f,H\\}$及[A,B]=AB−BA。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p.105/PDF127相邻两式的Hamiltonian Poisson括号顺序相反；本条保留印刷{H₁,H₂}。"
    }
  ],
  "lean_decl": "MD.Ch03.leadingShadowPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "F,H₁,H₂取C²，原文smooth资格明示。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem leadingShadowPrinted :
  ∀ (n : ℕ) (A B F : SymplecticCoordinates n → ℝ), ContDiff ℝ 2 A →
    ContDiff ℝ 2 B → ContDiff ℝ 2 F → ∀ z,
    hamiltonianLie A (hamiltonianLie B F) z-hamiltonianLie B (hamiltonianLie A F) z=
      hamiltonianLie (textbookPoissonBracket A B) F z
```

