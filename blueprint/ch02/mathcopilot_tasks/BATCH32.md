# BATCH32 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.5.5-Beeman
```json
{
  "source_id": "MD-2.5.5-Beeman",
  "kind": "definition",
  "label": "Example 2.8 (Beeman’s Algorithm)",
  "section": "2.5.5",
  "printed_page": "94",
  "pdf_page": "116",
  "statement_latex": "The method treats the positions and momenta differently, updating these from the formulas\n\\[\\boldsymbol q_{n+1}=\\boldsymbol q_n+h\\dot{\\boldsymbol q}_n+\\frac{h^2}{6}[4\\ddot{\\boldsymbol q}_n-\\ddot{\\boldsymbol q}_{n-1}].\\tag{2.31}\\]\n\\[\\boldsymbol p_{n+1}=\\boldsymbol p_n+\\frac h6 M[2\\ddot{\\boldsymbol q}_{n+1}+5\\ddot{\\boldsymbol q}_n-\\ddot{\\boldsymbol q}_{n-1}].\\tag{2.32}\\]\nThe shorthand $\\dot{\\boldsymbol q}_n\\equiv M^{-1}\\boldsymbol p_n$, $\\ddot{\\boldsymbol q}_n\\equiv M^{-1}F(\\boldsymbol q_n)$ has been used.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "需要前两个位置与当前动量；先qnext后F(qnext)，每步只需一个新force。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.beeman",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def beeman {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (qPrev : Q n) (z : Z n) : Z n :=
  let a := invMass m (F z.1)
  let aPrev := invMass m (F qPrev)
  let q := z.1+h • invMass m z.2+(h^2/6) • ((4 : ℝ) • a-aPrev)
  let p := z.2+(h/6) • mass m ((2 : ℝ) • invMass m (F q)+(5 : ℝ) • a-aPrev)
  (q,p)
```

### MD-2.5.5-BeemanOrder
```json
{
  "source_id": "MD-2.5.5-BeemanOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.5",
  "printed_page": "94",
  "pdf_page": "116",
  "statement_latex": "The order of accuracy of the scheme above can be shown to be three.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "三阶的阶定义需要裁定：单位质量谐振子q=cos t、p=−sin t，从两个精确起点代入原式，一步动量误差首项为−h³/12；全相空间全局三阶与该局部缺陷不一致。保留原文three及完整全局三阶签名，不静默改成二阶。"
    }
  ],
  "lean_decl": "MD.Ch02.beemanOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正固定对角质量，F C⁴；实际紧轨迹，前两步取精确起始值（强于三阶启动）；真实多步递推，保留两坐标误差。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem beemanOrder : ∀ n (m : Fin n → ℝ) (F : Q n → Q n)
    (γ : ℝ → Z n) τ,
    positiveMass m → ContDiff ℝ 4 F → 0 < τ →
    solution (mechanicalField m F) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
    ∃ C > 0, ∃ ν₀ : ℕ, 1 < ν₀ ∧ ∀ ν ≥ ν₀,
      ∀ z : ℕ → Z n, z 0=γ 0 → z 1=γ (τ/ν) →
        (∀ k, 1 ≤ k → z (k+1)=beeman m F (τ/ν) (z (k-1)).1 (z k)) →
        ∀ k ≤ ν, ‖z k-γ (k*(τ/ν))‖ ≤ C*(τ/ν)^3
```

