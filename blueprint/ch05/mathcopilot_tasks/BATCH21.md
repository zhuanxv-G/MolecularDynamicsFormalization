# BATCH21 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.4.1-CircleInitialPoints
```json
{
  "source_id": "MD-5.4.1-CircleInitialPoints",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "202",
  "pdf_page": "223",
  "statement_latex": "Now consider an alternative initial set. Begin, as before, with a line segment on the $x$-axis, but now choose the initial momenta from the uniform distribution on the circle $p_x^2+p_y^2=2(E_0-U(x,0))$. In this way we again get initial conditions on the $H=E_0$ energy surface, but this time the points are not close to one another in phase space, since the momenta of successive points may differ greatly.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际动量圆的角参数化；根号非负时对应书中圆，半径0允许退化点，均匀角概率推送另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.circleInitialPoints",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def circleInitialPoints (κ l ε c x θ : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])
```

### MD-5.4.1-CircleInitialLaw
```json
{
  "source_id": "MD-5.4.1-CircleInitialLaw",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "202",
  "pdf_page": "223",
  "statement_latex": "choose the initial momenta from the uniform distribution on the circle $p_x^2+p_y^2=2(E_0-U(x,0))$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.circleInitialLaw",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def circleInitialLaw (κ l ε c x : ℝ) : Measure (MolecularDynamics.Chapter05Review.Phase 2) :=
  Measure.map (circleInitialPoints κ l ε c x)
    ((ENNReal.ofReal (2*Real.pi))⁻¹ • (volume.restrict (Ioc (0 : ℝ) (2*Real.pi))))
```

### MD-5.4.1-CircleInitialEnergy
```json
{
  "source_id": "MD-5.4.1-CircleInitialEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "202",
  "pdf_page": "223",
  "statement_latex": "In this way we again get initial conditions on the $H=E_0$ energy surface.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.circleInitialEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem circleInitialEnergy : ∀ κ l ε c x θ : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := circleInitialPoints κ l ε c x θ
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c
```

