# BATCH06 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.3-LeadingModifiedExponential
```json
{
  "source_id": "MD-3.3-LeadingModifiedExponential",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "105",
  "pdf_page": "127",
  "statement_latex": "An alternative perspective on the error expansion in splitting. The idea is to view the product of exponentials as an exponential:\n\\[e^{hA}e^{hB}=e^{h(A+B+hR)},\\]\nfor some operator $R$. Expanding out the right hand side gives\n\\[\\begin{aligned}e^{h(A+B+hR)}&=\\mathrm{Id}+h(A+B+hR)+\\frac{h^2}{2}(A+B+hR)^2+\\cdots\\\\\n&=\\mathrm{Id}+hA+hB+h^2R+\\frac{h^2}{2}(A^2+AB+BA+B^2)+h^3((A+B)R+R(A+B))+\\cdots.\\end{aligned}\\]\nComparing this to our expansion for $e^{hA}e^{hB}$, for agreement to $O(h^2)$, we must have\n\\[\\frac12(2AB+A^2+B^2)-R+\\frac12(A^2+AB+BA+B^2)=O(h),\\]\nor\n\\[R=AB-\\frac12(AB+BA)=\\frac12[A,B]+O(h).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际形式系数匹配只到次数<3；上面印刷比较式及h³交叉项另有疑误，不改动转录。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p.105/PDF127比较式似应为二次系数之差（第二项前负号）；展示h³交叉项似缺1/2。最终R₀式与既有匹配一致。"
    }
  ],
  "lean_decl": "MD.Ch03.leadingModifiedExponential",
  "reusable_proofs": [
    "MolecularDynamics.textbookFormalModifiedExponential_matches_product"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem leadingModifiedExponential (A B : R) (n : ℕ) (hn : n < 3) :
    PowerSeries.coeff n
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      PowerSeries.coeff n
        (textbookFormalModifiedExponential A B ((1 / 2 : ℝ) • (A * B - B * A)))
```

### MD-3.3-LeadingShadowHamiltonian
```json
{
  "source_id": "MD-3.3-LeadingShadowHamiltonian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "105",
  "pdf_page": "127",
  "statement_latex": "and from this it follows that\n\\[e^{h\\mathcal L_{H_1}}e^{h\\mathcal L_{H_2}}=e^{h\\mathcal L_G},\\]\nwhere\n\\[G=H_1+H_2+\\frac h2\\{H_1,H_2\\}+O(h^2).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal L_HF=\\{F,H\\}$；本页Lie交换子后式疑误已单列；状态Φ_h∘Ψ_h与pullback次序相反。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "与同页印刷交换子和状态/pullback组合约定一起核对，不能静默换号。"
    }
  ],
  "lean_decl": "MD.Ch03.leadingShadowHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "D开放、K紧且K⊆D、A/B在D无限可微并给定真实局部流；实际修正ODE解及O(h³)端点余项为结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem leadingShadowHamiltonian :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ K, Γ h z 0=z ∧
        solution (textbookHamiltonianVectorField (fun x => A x+B x+h/2*textbookPoissonBracket A B x)) (Γ h z) 0 h ∧
        ‖Φ h (Ψ h z)-Γ h z h‖ ≤ C*h^3
```

### MD-3.3-BCH4
```json
{
  "source_id": "MD-3.3-BCH4",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "106",
  "pdf_page": "128",
  "statement_latex": "Higher order terms can also be worked out, for example,\n\\[e^Ae^B=\\exp\\left(A+B+\\frac12[A,B]+\\frac1{12}([A,[A,B]]-[B,[A,B]])-\\frac1{24}[B,[A,[A,B]]]+\\cdots\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A,B为非交换形式算子；重新插入形式变量h，按formalLog的次数1–4逐系数相等，不主张无限级数收敛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.bch4",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bch4 :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), ∀ j < 5,
    PowerSeries.coeff j (formalLog (formalSplitting A B))=PowerSeries.coeff j (bchLog4 A B)
```

### MD-3.3-BCHHamiltonian
```json
{
  "source_id": "MD-3.3-BCHHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "3.3",
  "printed_page": "106",
  "pdf_page": "128",
  "statement_latex": "and, using the correspondence between Lie and Poisson brackets,\n\\[e^{h\\mathcal L_{H_1}}e^{h\\mathcal L_{H_2}}=e^{h\\mathcal L_{\\widetilde H_h}},\\]\nwhere\n\\[\\widetilde H_h=H_1+H_2+\\frac h2\\{H_1,H_2\\}+\\frac{h^2}{12}\\bigl(\\{H_1,\\{H_1,H_2\\}\\}-\\{H_2,\\{H_1,H_2\\}\\}\\bigr)-\\frac{h^3}{24}\\{H_2,\\{H_1,\\{H_1,H_2\\}\\}\\}+\\cdots.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本定义只保存印刷到h³的有限函数；无穷省略号不作为已证匹配。实际匹配另条，保留印刷符号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.bchHamiltonian3",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bchHamiltonian3 {n : ℕ} (A B : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  A z+B z+h/2*textbookPoissonBracket A B z+
    h^2/12*(textbookPoissonBracket A (textbookPoissonBracket A B) z-
      textbookPoissonBracket B (textbookPoissonBracket A B) z)-
    h^3/24*textbookPoissonBracket B (textbookPoissonBracket A (textbookPoissonBracket A B)) z
```

### MD-3.3-BCHHamiltonianMatching
```json
{
  "source_id": "MD-3.3-BCHHamiltonianMatching",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "106",
  "pdf_page": "128",
  "statement_latex": "We refer to this series as the modified (also perturbed, shadow) Hamiltonian corresponding to the splitting method. The implication of the series is that the numerical method may be viewed as being equivalent to the exact solution of a nearby Hamiltonian system, although we have not addressed the convergence of the expansion.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "印刷有限系数见同页BCHHamiltonian；形式级数未讨论收敛。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "需确定原书组合顺序和有限截断的实际余项阶；未把匹配结论当假设。"
    }
  ],
  "lean_decl": "MD.Ch03.bchHamiltonianMatching",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际匹配按截断至h³、端点误差O(h⁵)表达；D开放、K紧、光滑Hamiltonian与真实局部流明示。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bchHamiltonianMatching :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    matchesHamiltonian (bchHamiltonian3 A B) (fun h => Φ h ∘ Ψ h) K 4
```

### MD-3.3-CommutingFlows
```json
{
  "source_id": "MD-3.3-CommutingFlows",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "106",
  "pdf_page": "128",
  "statement_latex": "If $H_1$ and $H_2$ Poisson-commute, i.e.\n\\[\\{H_1,H_2\\}=0,\\]\nthen there is no error in splitting.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页固定Hamiltonians及对应真实局部流；不假设两个流本身已相等。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.commutingFlows",
  "reusable_proofs": [],
  "extra_assumptions": [
    "光滑Hamiltonian、开放域及三个真实局部流；|h|<η/2保证复合时间在所给流的定义区间。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem commutingFlows :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ Ψ Χ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    (∀ z ∈ D, textbookPoissonBracket A B z=0) →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    actualFlow (textbookHamiltonianVectorField (fun z => A z+B z)) D Χ η →
    ∀ z ∈ D, ∀ h ∈ Ioo (-η/2) (η/2), Φ h (Ψ h z)=Χ h z
```

