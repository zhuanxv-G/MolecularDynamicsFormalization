# BATCH04 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.2.1-DomainL2
```json
{
  "source_id": "MD-5.2.1-DomainL2",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "The set of functions from $D\\subset\\mathbb R^m$ to $\\mathbb R$ which satisfy $\\int_D\\rho^2(z)\\,d\\omega<\\infty$ is referred to as the space $L^2(D)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Mathlib Lp使用Lebesgue可测函数的AE等价类；书中未写商空间，若不取AE类，所谓范数可能为0而原始函数非零。保留一般D；透明别名复用实际Lp的实例。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
@[reducible] def domainL2 (n : ℕ) (D : Set (MolecularDynamics.Chapter05Review.E n)) := Lp ℝ 2 (volume.restrict D)
```

### MD-5.2.1-L2Norm
```json
{
  "source_id": "MD-5.2.1-L2Norm",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "we define the $L^2(D)$ norm by $\\|\\rho\\|_{L^2(D)}\\stackrel{\\rm def}{=}[\\int_D\\rho^2(z)\\,d\\omega]^{1/2}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Lp范数；与原积分公式的等式独立定理，不将定义编译冒称公式已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2Norm",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def domainL2Norm {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖
```

### MD-5.2.1-L2Inner
```json
{
  "source_id": "MD-5.2.1-L2Inner",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "for any $\\phi,\\psi\\in L^2(D)$, the inner product is defined by $\\langle\\phi,\\psi\\rangle_{L^2(D)}\\stackrel{\\rm def}{=}\\int_D\\phi(z)\\psi(z)\\,d\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "在真实AE类的Mathlib可测代表上积分；乘积可积由Lp2保证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2Inner",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def domainL2Inner {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (f g : domainL2 n D) : ℝ :=
  ∫ z in D,f z*g z
```

### MD-5.2.1-L2NormSquare
```json
{
  "source_id": "MD-5.2.1-L2NormSquare",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "Thus $\\|\\rho\\|_{L^2(D)}^2=\\langle\\rho,\\rho\\rangle_{L^2(D)}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Lp内积到积分桥接，不假设范数积分公式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2NormSquare",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem domainL2NormSquare : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (g : domainL2 n D),
  domainL2Norm g^2=domainL2Inner g g
```

### MD-5.2.1-L2Complete
```json
{
  "source_id": "MD-5.2.1-L2Complete",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "This is a real Hilbert space or complete inner product space.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2Complete",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完备结论在AE商L²上；原生函数集合的正定性缺AE资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem domainL2Complete : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v)
```

### MD-5.2.1-L2SymmetricBilinear
```json
{
  "source_id": "MD-5.2.1-L2SymmetricBilinear",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "The inner product is a symmetric, bilinear operation: if $\\alpha,\\beta$ are real scalars and $f,g,h\\in L^2(D)$, then $\\langle\\alpha f+\\beta g,h\\rangle=\\alpha\\langle f,h\\rangle+\\beta\\langle g,h\\rangle$, and $\\langle f,g\\rangle=\\langle g,f\\rangle$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整两个结论都保留，在Lp商上以实际内积/积分桥接。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2SymmetricBilinear",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem domainL2SymmetricBilinear : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f g h : domainL2 n D) (a b : ℝ),
  domainL2Inner (a • f+b • g) h=a*domainL2Inner f h+b*domainL2Inner g h ∧
    domainL2Inner f g=domainL2Inner g f
```

### MD-5.2.1-CompactL2
```json
{
  "source_id": "MD-5.2.1-CompactL2",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "The space $L^2(\\mathbb R^m)$ includes for example the continuous functions with compact (closed, bounded) support, where the support of a function $f$ is the closure of the set of arguments for which the function is nonzero and is denoted $\\operatorname{supp}f$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "HasCompactSupport对应闭支持tsupport的紧性，Function.support只是非零集合。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.compactL2",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem compactL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  Continuous g → HasCompactSupport g → MemLp g 2 volume
```

### MD-5.2.1-DensityAverageOn
```json
{
  "source_id": "MD-5.2.1-DensityAverageOn",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "Given a density $\\rho$, we may identify a collection of functions $g$ for which the integral with respect to $\\rho$ is bounded, i.e. for which we can define the inner product $\\langle g,\\rho\\rangle=\\int_Dg(z)\\rho(z)\\,d\\omega$, and thus we can define\n\\[\\operatorname{Av}_\\rho(g)\\stackrel{\\rm def}{=}\\frac{1}{\\int_D\\rho(z)\\,d\\omega}\\langle g,\\rho\\rangle=\\int_Dg\\widehat\\rho\\,d\\omega.\\]\nWe term this the spatial average of the function $g$ with respect to the probability measure associated to $\\rho$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "平均的概率解释限于正的有限归一化分母及可积乘积；定义仅复现完整实际积分比值，不假设它是内积适用于任意g。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.densityAverageOn",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def densityAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ) : ℝ :=
  (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)
```

