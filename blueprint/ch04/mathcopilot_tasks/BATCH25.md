# BATCH25 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4.1-AxisRotation
```json
{
  "source_id": "MD-4.4.1-AxisRotation",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "173–174",
  "pdf_page": "195–196",
  "statement_latex": "Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7). The notation $\\Theta_x(\\phi)$ refers to a rotation around the x-axis by an angle $\\phi$, that is\n\\[\\Theta_x(\\phi)=\\begin{bmatrix}1&0&0\\\\0&\\cos\\phi&-\\sin\\phi\\\\0&\\sin\\phi&\\cos\\phi\\end{bmatrix},\\]\nwith corresponding formulae for $\\Theta_y$ and $\\Theta_z$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "右手主动轴旋转，Fin3为0,1,2对应书1,2,3。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.axisRotation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
```

### MD-4.4.1-SecondAxisPrinted
```json
{
  "source_id": "MD-4.4.1-SecondAxisPrinted",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "$\\dot\\pi=\\pi\\times[0,T_2^{-1}\\pi,0]^T$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p173第二子系统分量少下标2，原文尚需导师裁定。"
    }
  ],
  "lean_decl": "MD.Ch04.secondAxisPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "为未定义标量引入a供审校，不声称它等于π₂。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def secondAxisPrinted (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (a : ℝ) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,a/I 1,0]
```

### MD-4.4.1-ThirdAxisPrinted
```json
{
  "source_id": "MD-4.4.1-ThirdAxisPrinted",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "$\\dot\\pi=\\pi\\times[0,0,T_3^{-1}\\pi]^T$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p173第三子系统分量少下标3，单列保留原式。"
    }
  ],
  "lean_decl": "MD.Ch04.thirdAxisPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]a只为缺下标的印刷标量供审校。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def thirdAxisPrinted (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (a : ℝ) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,0,a/I 2]
```

### MD-4.4.1-PrincipalAxisField
```json
{
  "source_id": "MD-4.4.1-PrincipalAxisField",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "If $T$ is a diagonal matrix, $T=\\operatorname{diag}(I_1,I_2,I_3)$, then we split the Euler equations and approximate the solution by successive rotations around the three axes of inertia.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.principalAxisField",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]将第二和第三子场的分量分别明确为π₂/π₃；原印刷两处缺下标另列待审，不覆盖原式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-11",
      "reason": "原页高倍率复核纠正预备转录：列动量Rπ、方向ΘRᵀ与正式库一致；第二及第三拆分均缺下标。原记录归档，正角与π×ω子流符号疑点仍待审。",
      "before": "blueprint/ch04/validation/transcription-repair-20261011/BEFORE.json",
      "visual_sha256": {
        "blueprint/ch04/source_pages/p195-split-detail.png": "2187e0fc326143559f3ee751a3d628e8168e8376ed833d5b4d440bb1cf5039b0",
        "blueprint/ch04/source_pages/p196-spin-detail.png": "103c0a22caee08e216a7a749055fb24cd007afd063c43f0139555845b335c501"
      }
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def principalAxisField (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π (Pi.single i (π i/I i))
```

### MD-4.4.1-AxisFlowFormal
```json
{
  "source_id": "MD-4.4.1-AxisFlowFormal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "正角主动Rπ导数=ω×π，不是π×ω；精确流需负角列动量。"
    }
  ],
  "lean_decl": "MD.Ch04.axisFlow",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]旧声明使用与p174一致的正式库spinAxis；作为待审正角精确子流候选，不把它当已证原结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-11",
      "reason": "原页高倍率复核纠正预备转录：列动量Rπ、方向ΘRᵀ与正式库一致；第二及第三拆分均缺下标。原记录归档，正角与π×ω子流符号疑点仍待审。",
      "before": "blueprint/ch04/validation/transcription-repair-20261011/BEFORE.json",
      "visual_sha256": {
        "blueprint/ch04/source_pages/p195-split-detail.png": "2187e0fc326143559f3ee751a3d628e8168e8376ed833d5b4d440bb1cf5039b0",
        "blueprint/ch04/source_pages/p196-spin-detail.png": "103c0a22caee08e216a7a749055fb24cd007afd063c43f0139555845b335c501"
      }
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem axisFlow :
  ∀ (I π : MolecularDynamics.Chapter04Review.V) i, 0 < I i → ∀ t : ℝ,
  HasDerivAt (fun s : ℝ => (MolecularDynamics.Chapter04Review.spinAxis I i s (π,1)).1)
    (MolecularDynamics.Chapter04Review.cross3 ((MolecularDynamics.Chapter04Review.spinAxis I i t (π,1)).1) (Pi.single i (((MolecularDynamics.Chapter04Review.spinAxis I i t (π,1)).1 i)/I i))) t
```

### MD-4.4.1-SpinPoissonFormal
```json
{
  "source_id": "MD-4.4.1-SpinPoissonFormal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "This yields a simple, efficient algorithm for the free rigid body which is symplectic in a generalized sense.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.spinPoisson",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]此条仅正式库三维非canonical动量映射D J Dᵀ=J(Gπ)；Θ字面算法的完整几何结构另列。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem spinPoisson :
  ∀ I : MolecularDynamics.Chapter04Review.V, (∀ i, 0 < I i) → ∀ h : ℝ,
  poissonMap (fun π => (MolecularDynamics.Chapter04Review.spinStep I h (π,1)).1)
```

### MD-4.4.1-RigidPoissonSkew
```json
{
  "source_id": "MD-4.4.1-RigidPoissonSkew",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "$\\widetilde J(\\pi)=\\operatorname{skew}(\\pi)$ is obviously skew symmetric.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际矩阵转置等式；不把Jacobi条件或抽象非退化形式混作skew。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidPoissonSkew",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rigidPoissonSkew : ∀ π : MolecularDynamics.Chapter04Review.V, (MolecularDynamics.Chapter04Review.rigidPoissonMatrix π)ᵀ= -MolecularDynamics.Chapter04Review.rigidPoissonMatrix π
```

### MD-4.4.1-RigidHamiltonianField
```json
{
  "source_id": "MD-4.4.1-RigidHamiltonianField",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "Let us observe that (4.41) is in the form $\\dot\\pi=\\widetilde J(\\pi)\\nabla\\widetilde H$, where $\\widetilde J(\\pi)=\\operatorname{skew}(\\pi)$ is obviously skew symmetric, and $\\widetilde H=\\pi^TT^{-1}\\pi/2$ is the energy function.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidHamiltonianField",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正定T确保对称可逆；真实Fréchet配置梯度，不把∇H=T⁻¹π作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rigidHamiltonianField : ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V), T.PosDef →
  MolecularDynamics.Chapter04Review.eulerRigidField T π=MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ
    MolecularDynamics.Chapter04Review.grad (fun x => MolecularDynamics.Chapter04Review.dot x (T⁻¹ *ᵥ x)/2) π
```

