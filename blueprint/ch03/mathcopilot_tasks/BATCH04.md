# BATCH04 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.2-PoissonCoordinates
```json
{
  "source_id": "MD-3.2-PoissonCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "\\[\\{g_1,g_2\\}=\\sum_{i=1}^N\\left(\\frac{\\partial g_1}{\\partial q_i}\\frac{\\partial g_2}{\\partial p_i}-\\frac{\\partial g_2}{\\partial q_i}\\frac{\\partial g_1}{\\partial p_i}\\right)=\\nabla g_1^T J\\nabla g_2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$g_1,g_2$为同页smooth scalar-valued函数；实际Fréchet偏导对单位基向量作用。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonCoordinates",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_coordinates"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem poissonCoordinates (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = ∑ i : Fin Nc,
      ((fderiv ℝ F z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ G z) (Pi.single (Sum.inr i) 1) -
      (fderiv ℝ G z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ F z) (Pi.single (Sum.inr i) 1))
```

### MD-3.2-PoissonBilinearity
```json
{
  "source_id": "MD-3.2-PoissonBilinearity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables):\nBilinearity $\\{g_1,\\alpha g_2+\\beta g_3\\}=\\alpha\\{g_1,g_2\\}+\\beta\\{g_1,g_3\\}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\alpha,\\beta\\in\\mathbb R$；Poisson定义见同页；第一变量线性由下一条反对称性推出。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonBilinearity",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_linear_right",
    "MolecularDynamics.textbookPoissonBracket_linear_left"
  ],
  "extra_assumptions": [
    "原文smooth函数按点可微资格显式化；保留旧清单双变量线性的完整两条结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem poissonBilinearity (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z)
    (hH : DifferentiableAt ℝ H z) :
    (textbookPoissonBracket F (fun x => α*G x+β*H x) z =
      α*textbookPoissonBracket F G z+β*textbookPoissonBracket F H z) ∧
    (textbookPoissonBracket (fun x => α*F x+β*G x) H z =
      α*textbookPoissonBracket F H z+β*textbookPoissonBracket G H z)
```

### MD-3.2-PoissonSkew
```json
{
  "source_id": "MD-3.2-PoissonSkew",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "Skew symmetry $\\{g_1,g_2\\}=-\\{g_2,g_1\\}$",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$J$为同页规范辛矩阵；不要求J另有任意自定义参数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonSkew",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_skew"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem poissonSkew (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = -textbookPoissonBracket G F z
```

### MD-3.2-PoissonSelf
```json
{
  "source_id": "MD-3.2-PoissonSelf",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "and this implies $\\{g_1,g_1\\}=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "由同页Skew symmetry；实数域特征不为2。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonSelf",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_self"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem poissonSelf (F : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : textbookPoissonBracket F F z = 0
```

### MD-3.2-PoissonJacobi
```json
{
  "source_id": "MD-3.2-PoissonJacobi",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "Jacobi identity $\\{g_1,\\{g_2,g_3\\}\\}+\\{g_3,\\{g_1,g_2\\}\\}+\\{g_2,\\{g_3,g_1\\}\\}=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页三个smooth scalar-valued函数；非任意未微分函数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonJacobi",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_jacobi"
  ],
  "extra_assumptions": [
    "显式各函数在z为C²；真实二阶导数对称性支持Jacobi。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem poissonJacobi (F G H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (hH : ContDiffAt ℝ 2 H z) :
    textbookPoissonBracket F (textbookPoissonBracket G H) z +
      textbookPoissonBracket H (textbookPoissonBracket F G) z +
      textbookPoissonBracket G (textbookPoissonBracket H F) z = 0
```

### MD-3.2-HamiltonianObservableDerivative
```json
{
  "source_id": "MD-3.2-HamiltonianObservableDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "More generally, if $F(\\boldsymbol q,\\boldsymbol p)$ is any smooth, scalar-valued function of the phase variables, we may write\n\\[\\dot F=\\frac{\\mathrm d}{\\mathrm dt}F(\\boldsymbol q(t),\\boldsymbol p(t))=\\{F,H\\}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\gamma(t)=(q(t),p(t))$为实际Hamiltonian解。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianObservableDerivative",
  "reusable_proofs": [
    "MolecularDynamics.hasDerivAt_textbookLieDerivative"
  ],
  "extra_assumptions": [
    "smooth只需在γ(t)可微；ODE真实导数明示。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianObservableDerivative
    (F H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (t : ℝ) (hF : DifferentiableAt ℝ F (γ t))
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => F (γ u)) (textbookPoissonBracket F H (γ t)) t
```

### MD-3.2-HamiltonianLie
```json
{
  "source_id": "MD-3.2-HamiltonianLie",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "As a consequence, we have the following relation between the Lie derivative and the Poisson bracket:\n\\[\\mathcal L_{J\\nabla H}F=\\{F,H\\}.\\]\nFor a Hamiltonian flow, we typically simplify notation by writing $\\mathcal L_H$ in place of $\\mathcal L_{J\\nabla H}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal L_H=\\mathcal L_{J\\nabla H}$仅记号，旧CH03-025合并于此；实际hamiltonianLie定义亦为此。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianLie_eq_poisson",
  "reusable_proofs": [
    "MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianLie_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H
```

### MD-3.2-HamiltonianCoordinateDerivative
```json
{
  "source_id": "MD-3.2-HamiltonianCoordinateDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "In terms of the Poisson bracket, it is possible to write the differential equation corresponding to a coordinate $q_i$, say, as\n\\[\\dot q_i=\\{q_i,H\\}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$q_i$作为规范相空间上的坐标函数z↦z(Sum.inl i)，不是额外任意观测量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianCoordinateDerivative",
  "reusable_proofs": [
    "MolecularDynamics.hasDerivAt_textbookLieDerivative"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianCoordinateDerivative
    (H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (i : Fin Nc) (t : ℝ)
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => γ u (Sum.inl i))
      (textbookPoissonBracket (fun z => z (Sum.inl i)) H (γ t)) t
```

