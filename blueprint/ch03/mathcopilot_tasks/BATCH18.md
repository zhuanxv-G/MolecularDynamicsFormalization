# BATCH18 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.6.1-LinearInvolution
```json
{
  "source_id": "MD-3.6.1-LinearInvolution",
  "kind": "definition",
  "label": null,
  "section": "3.6.1",
  "printed_page": "128",
  "pdf_page": "150",
  "statement_latex": "By an involution we mean a linear mapping $\\boldsymbol z\\mapsto R\\boldsymbol z$ where $R^2=I$, i.e. $R$ is its own inverse.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "一般R²=I不蕴含Rᵀ=R或正交。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.linearInvolution",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
```

### MD-3.6.1-ReversedFieldPrinted
```json
{
  "source_id": "MD-3.6.1-ReversedFieldPrinted",
  "kind": "definition",
  "label": null,
  "section": "3.6.1",
  "printed_page": "128",
  "pdf_page": "150",
  "statement_latex": "Given the involution $R$ we define the time reversal of the vector field $f$ with respect to $R$ by\n\\[\\widetilde f(\\boldsymbol z)=-R^Tf(R\\boldsymbol z).\\]\nWhen a vector field is its own reversal we say that it is a time-reversible vector field.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "一般线性involution的时间反转应−R⁻¹f(Rz)=−Rf(Rz)，不是−Rᵀ；机械R对称时两者相同。"
    }
  ],
  "lean_decl": "MD.Ch03.reversedField",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def reversedField {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (z : Q n) : Q n :=
  -(R.transpose.mulVec (f (R.mulVec z)))
```

### MD-3.6.1-MomentumReversal
```json
{
  "source_id": "MD-3.6.1-MomentumReversal",
  "kind": "definition",
  "label": null,
  "section": "3.6.1",
  "printed_page": "128",
  "pdf_page": "150",
  "statement_latex": "Let $H(q,p)=p^TM^{-1}p/2+U(q)$ be the Hamiltonian for a system of $N_c$ configuration variables. Define the $2N_c\\times2N_c$ matrix $R$ by\n\\[R=\\begin{bmatrix}I&0\\\\0&-I\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "在Z n=Q n×Q n的等价坐标给(q,−p)；canonicalReversal是同一动作的pack坐标。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.momentumReversal",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def momentumReversal {n : ℕ} (z : Z n) : Z n := (z.1,-z.2)
```

### MD-3.6.1-MechanicalReversal
```json
{
  "source_id": "MD-3.6.1-MechanicalReversal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.1",
  "printed_page": "128",
  "pdf_page": "150",
  "statement_latex": "The vector fields involved are\n\\[f=\\begin{bmatrix}M^{-1}p\\\\-\\nabla U(q)\\end{bmatrix},\\qquad\\widetilde f=-Rf(Rz)=\\begin{bmatrix}-M^{-1}p\\\\\\nabla U(q)\\end{bmatrix},\\]\nwhich are clearly equal. Therefore the molecular dynamics Hamiltonian system is time-reversible.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原页右侧列向量实际写−M⁻¹p,+∇U，与左侧不等；−Rf(Rz)实际应等f。正确代数结论桥接，原展示式保留待审。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p128右端列向量符号与−Rf(Rz)实际计算不符；原文不静默更改。"
    }
  ],
  "lean_decl": "MD.Ch03.mechanicalReversalPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem mechanicalReversalPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n),
      (-momentumReversal (mechanicalField m (fun q => -grad U q) (momentumReversal z)) =
        (-invMass m z.2, grad U z.1)) ∧
      ((-invMass m z.2, grad U z.1) = mechanicalField m (fun q => -grad U q) z) ∧
      mechanicalField m (fun q => -grad U q) (momentumReversal z) =
        -momentumReversal (mechanicalField m (fun q => -grad U q) z)
```

### MD-3.6.1-ReversedTrajectoryPrinted
```json
{
  "source_id": "MD-3.6.1-ReversedTrajectoryPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.1",
  "printed_page": "128–129",
  "pdf_page": "150–151",
  "statement_latex": "For the system $\\mathrm dz/\\mathrm dt=f(\\boldsymbol z)$, a coordinate transformation $\\boldsymbol z\\mapsto\\widetilde{\\boldsymbol z}=R\\boldsymbol z$ results in\n\\[\\frac{\\mathrm d\\widetilde{\\boldsymbol z}}{\\mathrm dt}=R\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=Rf(R^{-1}\\widetilde{\\boldsymbol z})=Rf(R\\widetilde{\\boldsymbol z}),\\]\nsince $R^{-1}=R$. A change of time $t\\mapsto\\tau=-t$ results in\n\\[\\frac{\\mathrm d\\boldsymbol z}{\\mathrm d\\tau}=\\frac{\\mathrm dt}{\\mathrm d\\tau}\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=-f(\\boldsymbol z).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "将p128字面−Rᵀ定义代入反向轨道得到的待审断言；不是p129实际R链式法则的正确版本。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p128的Rᵀ字面反转与p129的R链式法则不能一般同时成立；具体二维反例见本地审计。"
    }
  ],
  "lean_decl": "MD.Ch03.reversedTrajectoryPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem reversedTrajectoryPrinted :
  ∀ (n : ℕ) (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
    R*R=1 → (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (fun s => R.mulVec (γ (-s)))
      (reversedField R f (R.mulVec (γ (-t)))) t
```

### MD-3.6.1-ReversedTrajectory
```json
{
  "source_id": "MD-3.6.1-ReversedTrajectory",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.1",
  "printed_page": "129",
  "pdf_page": "151",
  "statement_latex": "In other words, for a reversible vector field, the coordinate transformation $\\boldsymbol z\\mapsto R\\boldsymbol z$ is equivalent to the change of time $t\\mapsto-t$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "p129正确R链式法则版本；与字面Rᵀ断言分开；γ的真实时间导数明示。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.reversedTrajectory",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]采用正确f(Rz)=−Rf(z)而非一般Rᵀ字面定义；每个实t均有真实γ导数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem reversedTrajectory :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (γ : ℝ → Q n),
    linearInvolution R → (∀ z, f (R z)=-R (f z)) →
    (∀ t, HasDerivAt γ (f (γ t)) t) → ∀ t,
      HasDerivAt (fun s => R (γ (-s))) (f (R (γ (-t)))) t
```

### MD-3.6.1-MechanicalReversalCorrect
```json
{
  "source_id": "MD-3.6.1-MechanicalReversalCorrect",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.1",
  "printed_page": "128",
  "pdf_page": "150",
  "statement_latex": "Therefore the molecular dynamics Hamiltonian system is time-reversible.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "F=−grad U代入任意位置力版本；泛化不改变机械坐标反转对象。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.mechanicalReversalCorrect",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.mechanicalReversal_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]独立正确机械R反转结论；原书错误展示等式仍由MechanicalReversalPrinted保留，不静默更改它。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem mechanicalReversalCorrect :
  ∀ (n : ℕ) (m : Fin n → ℝ) (F : Q n → Q n) z,
    mechanicalField m F (momentumReversal z)=-momentumReversal (mechanicalField m F z)
```

