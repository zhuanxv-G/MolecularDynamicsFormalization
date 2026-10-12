# BATCH10 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.3.1-TestSpace
```json
{
  "source_id": "MD-5.3.1-TestSpace",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "188",
  "pdf_page": "209",
  "statement_latex": "The functions on which the generalized function acts are called test functions. Some choices for the space of test functions $\\mathcal T^m$ defined on $\\mathbb R^m$ include: the $C^\\infty$ functions with compact support in $\\mathbb R^m$, denoted $C_0^\\infty(\\mathbb R^m)$; the space $\\mathcal S(\\mathbb R^m)$ of $C^\\infty$ functions on $\\mathbb R^m$ whose derivatives decay rapidly at infinity (the so-called Schwarz space).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "两个测试空间选项都保留；紧支持C∞子类型是实际函数与资格，不把任意函数称测试函数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.testSpace",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ⊤ φ ∧ HasCompactSupport φ}
```

### MD-5.3.1-SchwartzSpace
```json
{
  "source_id": "MD-5.3.1-SchwartzSpace",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "188",
  "pdf_page": "209",
  "statement_latex": "The formal definition of $\\mathcal S$ is\n\\[\\mathcal S(\\mathbb R^m)\\stackrel{\\rm def}{=}\\{f\\in C^\\infty(\\mathbb R^m)\\mid\\|f\\|_{\\alpha,\\beta}<\\infty\\},\\]\nwhere $\\alpha$ and $\\beta$ are arbitrary multi-indices, i.e. vectors of non-negative integers, and\n\\[\\|f\\|_{\\alpha,\\beta}\\stackrel{\\rm def}{=}\\sup_{z\\in\\mathbb R^m}\\left|z_1^{\\alpha_1}z_2^{\\alpha_2}\\cdots z_m^{\\alpha_m}\\frac{\\partial^{\\beta_1+\\beta_2+\\cdots+\\beta_m}f}{\\partial z_1^{\\beta_1}\\partial z_2^{\\beta_2}\\cdots\\partial z_m^{\\beta_m}}\\right|.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.schwartzTestSpace",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Mathlib实际SchwartzMap以全阶Fréchet导数及多项式权界编码快速衰减；使用其既有空间，未把名称当任意类型。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def schwartzTestSpace (n : ℕ) := SchwartzMap (MolecularDynamics.Chapter05Review.E n) ℝ
```

### MD-5.3.1-GeneralizedFunction
```json
{
  "source_id": "MD-5.3.1-GeneralizedFunction",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "188",
  "pdf_page": "209",
  "statement_latex": "Formally, we define a generalized function as a real-valued linear operation (a linear functional) defined on a suitable space of functions.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "忠实代数线性定义，对任意适当实测试函数模块T；未偷偷加连续性，也未声称所有线性泛函都是标准连续分布。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.generalizedFunction",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def generalizedFunction (T : Type*) [AddCommGroup T] [Module ℝ T] := T →ₗ[ℝ] ℝ
```

### MD-5.3.1-SchwartzFunctional
```json
{
  "source_id": "MD-5.3.1-SchwartzFunctional",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "188",
  "pdf_page": "209",
  "statement_latex": "Formally, we define a generalized function as a real-valued linear operation (a linear functional) defined on a suitable space of functions.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.schwartzFunctional",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确选择原书第二个测试空间；上条泛型定义与紧支持C∞选项仍保留，不以Schwartz选择替换原文所有测试空间。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def schwartzFunctional (n : ℕ) := (MolecularDynamics.Chapter05Review.schwartzSpace n) →ₗ[ℝ] ℝ
```

### MD-5.3.1-RegularDistribution
```json
{
  "source_id": "MD-5.3.1-RegularDistribution",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "188",
  "pdf_page": "209",
  "statement_latex": "If $f$ is a bounded, smooth function on $\\mathbb R^m$, we may define a generalized function $T_f$ by reference to its action on a test function $\\phi\\in\\mathcal T$ via integration:\n\\[T_f(\\phi)=\\int_{\\mathbb R^m}f(z)\\phi(z)d\\omega.\\]\nThis is very like the $L^2$ inner product, but the functions involved do not both need to lie in $L^2$. Nevertheless, we write $T_f(\\phi)=\\langle f,\\phi\\rangle$, as a helpful shorthand.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Lebesgue积分配对；线性泛函性质及有界光滑f下可积性须另证，定义编译未代替这一结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.regularDistribution",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def regularDistribution {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := ∫ z, f z*φ z
```

### MD-5.3.1-RegularDistributionLinearity
```json
{
  "source_id": "MD-5.3.1-RegularDistributionLinearity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.1",
  "printed_page": "188",
  "pdf_page": "209",
  "statement_latex": "If $f$ is a bounded, smooth function on $\\mathbb R^m$, we may define a generalized function $T_f$ by reference to its action on a test function $\\phi\\in\\mathcal T$ via integration: $T_f(\\phi)=\\int_{\\mathbb R^m}f(z)\\phi(z)d\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.regularDistributionLinearity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原有界光滑f及明确选择的Schwartz测试空间；可积与完整线性两个结论都保留，不把可积作结论假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem regularDistributionLinearity : ∀ n (f : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ ⊤ f → (∃ C : ℝ,∀ z,|f z| ≤ C) →
  (∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,Integrable (fun z => f z*φ z) volume) ∧
  (∀ (φ ψ : MolecularDynamics.Chapter05Review.schwartzSpace n) (a b : ℝ),
    MolecularDynamics.Chapter05Review.regularDistribution f (a • φ+b • ψ)=a*MolecularDynamics.Chapter05Review.regularDistribution f φ+b*MolecularDynamics.Chapter05Review.regularDistribution f ψ)
```

### MD-5.3.1-DiracAction
```json
{
  "source_id": "MD-5.3.1-DiracAction",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "For the Dirac delta $\\delta$, its action on a function $\\phi\\in\\mathcal T$ is $\\delta[\\phi]=\\phi(0)$. We write this also as $\\langle\\delta,\\phi\\rangle=\\int\\delta(z)\\phi(z)d\\omega=\\phi(0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "评价泛函是真实φ(0)；形式δ(z)不是Lebesgue普通密度；其实际Dirac测度另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.diracAction",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def diracAction {n : ℕ} (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := φ 0
```

### MD-5.3.1-DiracMeasure
```json
{
  "source_id": "MD-5.3.1-DiracMeasure",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "For the Dirac delta $\\delta$, its action on a function $\\phi\\in\\mathcal T$ is $\\delta[\\phi]=\\phi(0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Measure.dirac 0；不能说δ具有普通光滑Lebesgue密度。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.diracMeasure",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def diracMeasure (n : ℕ) : Measure (MolecularDynamics.Chapter05Review.E n) := Measure.dirac 0
```

