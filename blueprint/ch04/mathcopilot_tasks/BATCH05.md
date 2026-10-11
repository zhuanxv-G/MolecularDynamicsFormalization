# BATCH05 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.2.1-ImpulseTrace
```json
{
  "source_id": "MD-4.2.1-ImpulseTrace",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "146",
  "pdf_page": "168",
  "statement_latex": "On the other hand, a short calculation shows that\n\\[\\lambda_1+\\lambda_2=\\operatorname{Tr}(W_h)=2\\cos(h\\Omega)-\\frac h\\Omega\\sin(h\\Omega).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.impulseTrace",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem impulseTrace :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace=2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω)
```

### MD-4.2.1-ResonancePower
```json
{
  "source_id": "MD-4.2.1-ResonancePower",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "146",
  "pdf_page": "168",
  "statement_latex": "For example, at $h=\\pi/\\Omega$, we have\n\\[F_h=-I\\Rightarrow W_h=-S_{h/2}^2=-\\begin{bmatrix}1&0\\\\-h&1\\end{bmatrix},\\]\nso that\n\\[W_h^n=(-1)^n\\begin{bmatrix}1&0\\\\-nh&1\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.resonancePower",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω>0；所有自然数k，不止图中有限迭代。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem resonancePower :
  ∀ Ω : ℝ, 0 < Ω → ∀ k : ℕ,
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k=(-1 : ℝ)^k • !![1,0; -(k : ℝ)*(Real.pi/Ω),1]
```

### MD-4.2.1-ResonanceTaylor
```json
{
  "source_id": "MD-4.2.1-ResonanceTaylor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "147",
  "pdf_page": "169",
  "statement_latex": "We can see this by expanding $\\mu(h)=2\\cos(h\\Omega)-\\frac h\\Omega\\sin(h\\Omega)$ in a Taylor expansion around $h=\\pi/\\Omega$:\n\\[\\mu(h)=-2+\\varepsilon,\\qquad\\varepsilon=\\frac\\pi\\Omega(h-\\pi/\\Omega).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.resonanceTaylor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem resonanceTaylor :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2
```

### MD-4.2.1-ResonanceInstability
```json
{
  "source_id": "MD-4.2.1-ResonanceInstability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "147",
  "pdf_page": "169",
  "statement_latex": "Here both eigenvalues are real and one is outside the unit circle. There is thus a small interval of exponential instability directly below $h=\\pi/\\Omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.resonanceInstability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω>0；存在左邻域，每个h有真实复谱模>1。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem resonanceInstability :
  ∀ Ω : ℝ, 0 < Ω → ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)
```

### MD-4.2.1-ResonanceEigenPrinted
```json
{
  "source_id": "MD-4.2.1-ResonanceEigenPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "147",
  "pdf_page": "169",
  "statement_latex": "For $\\varepsilon<0$, however, we have\n\\[\\lambda=-1\\pm(|\\varepsilon|/2)^{1/2}+O(\\varepsilon).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "根展开首项疑少sqrt(2)因子；待网站/导师裁定。"
    }
  ],
  "lean_decl": "MD.Ch04.resonanceEigenPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem resonanceEigenPrinted :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), ∃ rho : ℝ,
    (rho • (1 : Matrix (Fin 2) (Fin 2) ℝ)-MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=0 ∧
    |rho+1-Real.sqrt (|(Real.pi/Ω)*(h-Real.pi/Ω)|/2)| ≤ C*|h-Real.pi/Ω|
```

### MD-4.2.1-ResonanceLinearRate
```json
{
  "source_id": "MD-4.2.1-ResonanceLinearRate",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "147",
  "pdf_page": "169",
  "statement_latex": "and the norm of the solution will oscillate and grow linearly with $n$ as $n\\to\\infty$. This is the simplest type of linear resonance present in multiple timestepping.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "前条保持所有矩阵幂精确式，divergence另条；本条不把线性增长弱化为仅趋无穷。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.resonanceLinearRate",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]选实际Pi最大范数给出精确正线性率；q0≠0，否则此增长结论不成立。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem resonanceLinearRate : ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
    atTop (𝓝 (|(Real.pi/Ω)*z 0|))
```

### MD-4.2.1-ResonanceGrowth
```json
{
  "source_id": "MD-4.2.1-ResonanceGrowth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "147",
  "pdf_page": "169",
  "statement_latex": "and the norm of the solution will oscillate and grow linearly with $n$ as $n\\to\\infty$. This is the simplest type of linear resonance present in multiple timestepping.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际所有矩阵幂作用的范数趋无穷；线性率可从前条幂公式读取，尚未声称已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.resonanceGrowth",
  "reusable_proofs": [],
  "extra_assumptions": [
    "原泛称增长补q0≠0；q0=0时纯动量轨道模不增长。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem resonanceGrowth :
  ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖) atTop atTop
```

