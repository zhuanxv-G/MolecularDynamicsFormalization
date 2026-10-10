# BATCH11 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.3.4-TakahashiPotential
```json
{
  "source_id": "MD-3.3.4-TakahashiPotential",
  "kind": "definition",
  "label": null,
  "section": "3.3.4",
  "printed_page": "112",
  "pdf_page": "134",
  "statement_latex": "Recall the Takahashi-Imada method introduced in the last chapter.\n\\[\\widehat P:=p-(h/2)\\nabla\\widetilde U(q),\\qquad Q:=q+hM^{-1}\\widehat P,\\qquad P:=\\widehat P-(h/2)\\nabla\\widetilde U(Q),\\]\nwith modified potential energy function\n\\[\\widetilde U(q)=U(q)-\\frac{h^2}{24}\\nabla U(q)^TM^{-1}\\nabla U(q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际takahashiPotential体为U−h²/24 ∑ᵢ(grad U)ᵢ²/mᵢ，实际kick-drift-kick梯度取整个修正势。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.takahashiImada",
  "reusable_proofs": [],
  "extra_assumptions": [
    "M为固定对角质量矩阵，原第1章机械模型。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def takahashiImada {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  coordinateVerlet m (textbookPotentialForce (takahashiPotential m U h)) h
```

### MD-3.3.4-PotentialDoubleBracket
```json
{
  "source_id": "MD-3.3.4-PotentialDoubleBracket",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.4",
  "printed_page": "112",
  "pdf_page": "134",
  "statement_latex": "One might recognize the modification as being proportional to one part of the commutator expansion in the Verlet method, in fact\n\\[\\nabla U(q)^TM^{-1}\\nabla U(q)=\\{U,\\{U,T\\}\\}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$T=½p^TM^{-1}p$；U只依赖q；固定规范Poisson约定。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.potentialDoubleBracket",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正对角质量、U全域C²，显式化真实二次Poisson括号的微分资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem potentialDoubleBracket :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ 2 U → ∀ z : Z n,
    (∑ i, grad U z.1 i*invMass m (grad U z.1) i)=
      textbookPoissonBracket (fun x => U (unpack x).1)
        (textbookPoissonBracket (fun x => U (unpack x).1) (fun x => quadraticKinetic m (unpack x).2)) (pack z)
```

### MD-3.3.4-TakahashiShadow
```json
{
  "source_id": "MD-3.3.4-TakahashiShadow",
  "kind": "definition",
  "label": null,
  "section": "3.3.4",
  "printed_page": "112",
  "pdf_page": "134",
  "statement_latex": "This is certainly not a coincidence. If we replace the potential $U$ by $\\widetilde U$ in the Verlet expansion, we have\n\\[\\begin{aligned}\\widetilde H_h&=T+\\widetilde U+\\frac{h^2}{12}\\left(\\{T,\\{T,\\widetilde U\\}\\}-\\frac12\\{\\widetilde U,\\{\\widetilde U,T\\}\\}\\right)+O(h^4)\\\\\n&=T+U-\\frac{h^2}{24}\\{U,\\{U,T\\}\\}+\\frac{h^2}{12}\\left(\\{T,\\{T,\\widetilde U\\}\\}-\\frac12\\{\\widetilde U,\\{\\widetilde U,T\\}\\}\\right)+O(h^4)\\\\\n&=H+\\frac{h^2}{12}\\left(\\{T,\\{T,\\widetilde U\\}\\}-\\{\\widetilde U,\\{\\widetilde U,T\\}\\}\\right)+O(h^4)\\\\\n&=H+\\frac{h^2}{12}\\left(p^TM^{-1}U''M^{-1}p-\\nabla U^TM^{-1}\\nabla U\\right)+O(h^4).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书同段推导完整存于statement_latex；有限函数定义不证明该推导或实际余项。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条存最后展示式到h²的有限函数；Poisson→梯度推导属前条待证明，不把定义称为已证实际匹配。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.takahashiShadow2",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def takahashiShadow2 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1)
```

### MD-3.3.4-TakahashiProcessor
```json
{
  "source_id": "MD-3.3.4-TakahashiProcessor",
  "kind": "definition",
  "label": "(3.9)",
  "section": "3.3.4",
  "printed_page": "113",
  "pdf_page": "135",
  "statement_latex": "Introducing coordinate transformations\n\\[\\widetilde q=q-\\frac{h^2}{12}M^{-1}\\nabla U(q),\\qquad\\widetilde p=p+\\frac{h^2}{12}U''(q)M^{-1}p,\\tag{3.9}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "前句“Introducing coordinate transformations”位于p.112/PDF134末尾；不由此定义假设该变换全局可逆。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.takahashiProcessor",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def takahashiProcessor {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : Z n :=
  (z.1-(h^2/12) • invMass m (grad U z.1), z.2+(h^2/12) • hessianAction U z.1 (invMass m z.2))
```

### MD-3.3.4-ProcessorEnergyPrinted
```json
{
  "source_id": "MD-3.3.4-ProcessorEnergyPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.4",
  "printed_page": "113",
  "pdf_page": "135",
  "statement_latex": "and inserting these into $H$ yields, after expanding in a Taylor series:\n\\[\\begin{aligned}H(\\widetilde q,\\widetilde p)&=T+\\frac{h^2}{12}\\left(p^TM^{-1}U''M^{-1}p-\\nabla U^TM^{-1}\\nabla U\\right)+O(h^4)\\\\\n&=\\widetilde H_h(q,p)+O(h^4).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "T仅为动能，不等于H=T+U；同页第二行的H̃及p.112/PDF134定义包含U。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "第一行“T + h²/12(...)”似应为“H + h²/12(...)”；原文逐字保留，未改变正式库。"
    }
  ],
  "lean_decl": "MD.Ch03.processorEnergyPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正对角质量、U全域C⁴、紧初值集B；展示O(h⁴)按小h统一实际余项解释。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem processorEnergyPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (Z n)),
      positiveMass m → ContDiff ℝ 4 U → IsCompact B →
      ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
        (|mechanicalEnergy m U (takahashiProcessor m U h z) -
          (quadraticKinetic m z.2+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1))|
          ≤ C*h^4) ∧
        (|mechanicalEnergy m U (takahashiProcessor m U h z)-takahashiShadow2 m U h z|
          ≤ C*h^4)
```

### MD-3.3.4-TakahashiEffectiveOrder
```json
{
  "source_id": "MD-3.3.4-TakahashiEffectiveOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.4",
  "printed_page": "113",
  "pdf_page": "135",
  "statement_latex": "Since $\\widetilde H_h$ is assumed to be constant along the numerical solution, the coordinate transformations have the result of giving an effective order of four for the energy. It turns out that the Takahashi-Imada method is, more generally, an effective 4th order scheme, i.e. for arbitrary quantities, not just the energy [166].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "与第2章同方法的有效阶陈述对应；处理方法为χ⁻¹∘G∘χ，实际轨迹误差保留，不只证明能量。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "全局χ是否过强，以及可选局部处理器和其作用方向，需导师判断。"
    }
  ],
  "lean_decl": "MD.Ch03.takahashiEffectiveOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正对角质量、U全域C∞、实际有限时间解连续；处理器χ要求全局homeomorphism，强于原文局部坐标展开。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem takahashiEffectiveOrder :
    ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
      ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
        solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
        ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
          oneStepMaxError (fun h => textbookProcessedMethod χ
            (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
            (τ/ν) γ ν ≤ C*(τ/ν)^4
```

