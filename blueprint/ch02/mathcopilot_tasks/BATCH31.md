# BATCH31 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.5.4-MultiTaylor
```json
{
  "source_id": "MD-2.5.4-MultiTaylor",
  "kind": "definition",
  "label": null,
  "section": "2.5.4",
  "printed_page": "92",
  "pdf_page": "114",
  "statement_latex": "we may approximate a single step by\n\\[\\boldsymbol z_{n+1}=\\boldsymbol z_n+h\\dot{\\boldsymbol z}_n+\\frac{h^2}{2}\\ddot{\\boldsymbol z}_n+\\cdots+\\frac{h^k}{k!}\\boldsymbol z_n^{(k)},\\]\nwhere it is possible to make use of higher order derivatives of the solution in formulating the method. Then using the differential equation, the time derivatives may be replaced by elementary differentials of the vector field.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "dⱼ是真实解j阶时间导数数据，不把任意数据当作已有Taylor阶证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_multiTaylor",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_multiTaylor {n : ℕ} (d : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  ∑ j ∈ Finset.range (k+1), (h^j / (Nat.factorial j : ℝ)) • d j
```

### MD-2.5.4-TIPotential
```json
{
  "source_id": "MD-2.5.4-TIPotential",
  "kind": "definition",
  "label": null,
  "section": "2.5.4",
  "printed_page": "92–93",
  "pdf_page": "114–115",
  "statement_latex": "the Takahashi-Imada method [355] (also known as Rowlands’ method [316]) has the same form as the Verlet method\n\\[\\hat{\\boldsymbol P}=\\boldsymbol p-(h/2)\\nabla\\tilde U(\\boldsymbol q),\\quad\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\hat{\\boldsymbol P},\\quad\\boldsymbol P=\\hat{\\boldsymbol P}-(h/2)\\nabla\\tilde U(\\boldsymbol Q),\\]\nwhere the corresponding potential energy function is\n\\[\\tilde U(\\boldsymbol q)=U(\\boldsymbol q)-\\frac{h^2}{24}\\nabla U(\\boldsymbol q)^TM^{-1}\\nabla U(\\boldsymbol q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际改势已递归引用takahashiPotential；完整Verlet映射而非只记势能符号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.tiMethod",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def tiMethod {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : Z n → Z n :=
  verlet m (fun q => -grad (takahashiPotential m U h) q) h
```

### MD-2.5.4-TIForce
```json
{
  "source_id": "MD-2.5.4-TIForce",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.4",
  "printed_page": "93",
  "pdf_page": "115",
  "statement_latex": "The forces arising from such a modified potential can be worked out:\n\\[\\tilde F=-\\nabla\\tilde U=-\\left[I+\\frac{h^2}{12}U''M^{-1}\\right]\\nabla U,\\]\nwhere $U''$ is the Hessian matrix of the potential.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "上项改势为U−h²‖gradU‖²M⁻¹/24，负梯度应有+ h²Hessian项；原页此力式负号冲突，保留字面。"
    }
  ],
  "lean_decl": "MD.Ch02.tiForce",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量，U C²，真实改势梯度及Hessian作用。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem tiForce :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h q,
    positiveMass m → ContDiff ℝ 2 U →
    -grad (takahashiPotential m U h) q =
      -grad U q - (h^2/12) • (fderiv ℝ (grad U) q) (invMass m (grad U q))
```

### MD-2.5.4-TIOrder
```json
{
  "source_id": "MD-2.5.4-TIOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.4",
  "printed_page": "93",
  "pdf_page": "115",
  "statement_latex": "This method can be shown to have effective order four, meaning that there is a change of variables $\\chi_h$ which can be used to transform the Takahashi-Imada method into one of order four using the processing technique of Sect. 2.4.5. The potential energy modification has been specifically chosen to annihilate terms in the local error expansion (after coordinate transformation).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "DEPENDENT_ERRATUM",
      "status": "NEEDS_HUMAN",
      "detail": "有效四阶依赖改势符号；原文改势和力相互冲突，本签名保留负号改势，需裁定处理器方向和正负修正。"
    }
  ],
  "lean_decl": "MD.Ch02.tiOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量，U C∞；实际步依照上项负号改势；处理器为实际Homeomorph，原轨迹及有限时间窗误差结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem tiOrder :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
    ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
      solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
      ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        oneStepMaxError (fun h => textbookProcessedMethod χ
          (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
          (τ/ν) γ ν ≤ C*(τ/ν)^4
```

