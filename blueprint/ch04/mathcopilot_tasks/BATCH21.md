# BATCH21 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4-RotationTraceIdentity
```json
{
  "source_id": "MD-4.4-RotationTraceIdentity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "$K_{\\rm rot}=\\frac12\\sum_{i=1}^Nm_i\\delta_i(0)^T\\dot\\Theta^T\\dot\\Theta\\delta_i(0)$. This expression may be rewritten as $K_{\\rm rot}=\\frac12\\operatorname{Tr}[\\dot\\Theta R\\dot\\Theta^T]$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationTraceIdentity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rotationTraceIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (dΘ : MolecularDynamics.Chapter04Review.Mat3),
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (dΘ *ᵥ δ i) (dΘ *ᵥ δ i))/2=
      MolecularDynamics.Chapter04Review.rotationKinetic (MolecularDynamics.Chapter04Review.secondMoment m δ) dΘ
```

### MD-4.4-RotationSkew
```json
{
  "source_id": "MD-4.4-RotationSkew",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168–169",
  "pdf_page": "190–191",
  "statement_latex": "Moreover, since $\\Theta\\Theta^T=I$, we have $\\dot\\Theta\\Theta^T+\\Theta\\dot\\Theta^T=0$, which indicates that $\\dot\\Theta\\Theta^T$ is a skew symmetric matrix.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationSkew",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实HasDerivAt矩阵轨道与邻域正交约束；不假设导数乘积恒等式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rotationSkew :
  ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) t d,
  HasDerivAt Θ d t → (∀ᶠ s in 𝓝 t, Θ s*(Θ s)ᵀ=1) → (d*(Θ t)ᵀ)ᵀ=-(d*(Θ t)ᵀ)
```

### MD-4.4-SkewMatrix
```json
{
  "source_id": "MD-4.4-SkewMatrix",
  "kind": "definition",
  "label": "(4.38)",
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "Any $3\\times3$ skew matrix may be written as\n\\[\\dot\\Theta\\Theta^T=\\operatorname{skew}(\\omega)\\equiv\\begin{bmatrix}0&-\\omega_3&\\omega_2\\\\\\omega_3&0&-\\omega_1\\\\-\\omega_2&\\omega_1&0\\end{bmatrix}.\\tag{4.38}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条定义实际skew；任意skew有此唯一表示另条，不能省作已证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.skewMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```

### MD-4.4-CrossProduct
```json
{
  "source_id": "MD-4.4-CrossProduct",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$\\frac d{dt}\\delta_i=\\operatorname{skew}(\\omega)\\delta_i=\\omega\\times\\delta_i=-\\operatorname{skew}(\\delta_i)\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "右手cross3有限坐标定义；实际导数运动学另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.cross3",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```

### MD-4.4-SkewRepresentation
```json
{
  "source_id": "MD-4.4-SkewRepresentation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "Any $3\\times3$ skew matrix may be written as $\\operatorname{skew}(\\omega)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.skewRepresentation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem skewRepresentation : ∀ A : MolecularDynamics.Chapter04Review.Mat3, Aᵀ = -A → ∃! «ω» : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix «ω»=A
```

### MD-4.4-CrossMatrix
```json
{
  "source_id": "MD-4.4-CrossMatrix",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$\\operatorname{skew}(\\omega)\\delta_i=\\omega\\times\\delta_i=-\\operatorname{skew}(\\delta_i)\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.crossMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]本条仅首等式的子引理；原式两个等式全部保存在CrossIdentityFull，不把子引理当全部结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem crossMatrix :
  ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix u *ᵥ v=MolecularDynamics.Chapter04Review.cross3 u v
```

### MD-4.4-RigidVelocity
```json
{
  "source_id": "MD-4.4-RigidVelocity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$\\frac d{dt}\\delta_i=\\operatorname{skew}(\\omega)\\delta_i=\\omega\\times\\delta_i=-\\operatorname{skew}(\\delta_i)\\omega$, which is the usual definition.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidVelocity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "给定真实正交旋转轨道和定义角速度的skew关系；不是把速度公式当假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rigidVelocity : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (dΘ : MolecularDynamics.Chapter04Review.Mat3) (δ «ω» : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ dΘ t → Θ t*(Θ t)ᵀ=1 → dΘ*(Θ t)ᵀ=MolecularDynamics.Chapter04Review.skewMatrix «ω» →
    HasDerivAt (fun s => Θ s *ᵥ δ) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ)) t
```

### MD-4.4-InertiaTensor
```json
{
  "source_id": "MD-4.4-InertiaTensor",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$K_{\\rm rot}=\\frac12\\omega_b^TT\\omega_b$, where the matrix $T=-\\sum_{i=1}^Nm_i\\operatorname{skew}(\\delta_i(0))^2$ is referred to as the moment of inertia tensor or simply the inertia tensor and can be written as\n\\[T=\\sum_{i=1}^Nm_i[\\|\\delta_i(0)\\|^2I-\\delta_i(0)\\delta_i(0)^T].\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Euclidean有限和定义；skew²等价另条，动能标量定义另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.inertiaTensor",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 :=
  ∑ i, m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))
```

