# BATCH07 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.3.1-SymplecticEulerShadow
```json
{
  "source_id": "MD-3.3.1-SymplecticEulerShadow",
  "kind": "definition",
  "label": null,
  "section": "3.3.1",
  "printed_page": "106",
  "pdf_page": "128",
  "statement_latex": "Splitting our Hamiltonian using $H_1=T(\\boldsymbol p)=\\boldsymbol p^TM^{-1}\\boldsymbol p/2$ and $H_2=U(\\boldsymbol q)$ gives the symplectic Euler method. The BCH expansion gives the perturbed Hamiltonian\n\\[\\widetilde H_h=H-\\frac h2\\boldsymbol p^TM^{-1}\\nabla U(\\boldsymbol q)+\\frac{h^2}{12}\\bigl(\\boldsymbol p^TM^{-1}U''(\\boldsymbol q)M^{-1}\\boldsymbol p+\\nabla U(\\boldsymbol q)^TM^{-1}\\nabla U(\\boldsymbol q)\\bigr)-\\frac{h^3}{12}\\nabla U(\\boldsymbol q)^TM^{-1}U''(\\boldsymbol q)M^{-1}\\boldsymbol p+O(h^4).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实梯度与Hessian作用；本条只存有限函数，匹配另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.symplecticEulerShadow3",
  "reusable_proofs": [],
  "extra_assumptions": [
    "M取固定对角质量矩阵，与第1章机械模型一致；不包括任意非对角M。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def symplecticEulerShadow3 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z-h/2*(∑ i, invMass m z.2 i*grad U z.1 i)+
    h^2/12*((shadowTerms m U z).1+(shadowTerms m U z).2.1)-h^3/12*(shadowTerms m U z).2.2
```

### MD-3.3.1-SymplecticEulerShadowMatching
```json
{
  "source_id": "MD-3.3.1-SymplecticEulerShadowMatching",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.1",
  "printed_page": "106",
  "pdf_page": "128",
  "statement_latex": "The BCH expansion gives the perturbed Hamiltonian",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页展示式逐字保存在SymplecticEulerShadow；数值symplectic Euler采用第2章坐标约定。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "原文只写Hamiltonian O(h⁴)，实际端点O(h⁵)解释与数值坐标顺序待审。"
    }
  ],
  "lean_decl": "MD.Ch03.symplecticEulerShadowMatching",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正对角质量、U全域C∞、紧初值集B；截断h³的实际局部流端点O(h⁵)为额外严格化。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerShadowMatching :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ⊤ U → IsCompact B →
    matchesHamiltonian (fun h z => symplecticEulerShadow3 m U h (unpack z))
      (textbookSymplecticEuler m U) B 4
```

