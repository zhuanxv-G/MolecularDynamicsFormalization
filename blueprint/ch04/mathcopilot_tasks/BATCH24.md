# BATCH24 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4.1-AngularMomentum
```json
{
  "source_id": "MD-4.4.1-AngularMomentum",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "171",
  "pdf_page": "193",
  "statement_latex": "The angular momentum vector in the reference frame is given by $l=\\sum_{i=1}^Nm_i\\delta_i\\times\\dot\\delta_i$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.angularMomentum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  ∑ i, m i • MolecularDynamics.Chapter04Review.cross3 (δ i) (v i)
```

### MD-4.4.1-BodyMomentum
```json
{
  "source_id": "MD-4.4.1-BodyMomentum",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "171",
  "pdf_page": "193",
  "statement_latex": "Define $\\pi=\\Theta^Tl$, the angular momentum vector referred to the body frame of reference.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.bodyMomentum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bodyMomentum (Θ : MolecularDynamics.Chapter04Review.Mat3) (l : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := Θᵀ *ᵥ l
```

### MD-4.4.1-AngularInertia
```json
{
  "source_id": "MD-4.4.1-AngularInertia",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "171",
  "pdf_page": "193",
  "statement_latex": "From Eq. (4.39) we may write this as $l=\\sum_im_i\\delta_i\\times\\omega\\times\\delta_i$, from which, using the vector triple product identity $a\\times b\\times c=(a\\cdot c)b-(a\\cdot b)c$, we obtain $l=\\sum_im_i[\\|\\delta_i\\|^2I-\\delta_i\\delta_i^T]\\omega$. Define $\\pi=\\Theta^Tl$, then we have (using $\\delta_i=\\Theta\\delta_i(0)$): $\\pi=T\\omega_b$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.angularInertia",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实SO(3)矩阵和cross3，嵌套为δ×(ω×δ)；原无括号三重积含糊，明确上下文对象。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem angularInertia :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 → MolecularDynamics.Chapter04Review.bodyMomentum Θ
    (MolecularDynamics.Chapter04Review.angularMomentum m (fun i => Θ *ᵥ δ i) (fun i => MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i))) =
      MolecularDynamics.Chapter04Review.inertiaTensor m δ *ᵥ (Θᵀ *ᵥ «ω»)
```

### MD-4.4.1-EulerRigidField
```json
{
  "source_id": "MD-4.4.1-EulerRigidField",
  "kind": "definition",
  "label": "(4.41)",
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "but since $\\omega_b=T^{-1}\\pi$, we may conclude $\\dot\\pi=\\pi\\times T^{-1}\\pi$. These are the so-called Euler equations for the free rigid body.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.eulerRigidField",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def eulerRigidField (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := MolecularDynamics.Chapter04Review.cross3 π (T⁻¹ *ᵥ π)
```

### MD-4.4.1-FreeRigidSolution
```json
{
  "source_id": "MD-4.4.1-FreeRigidSolution",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "$\\dot\\pi=\\pi\\times T^{-1}\\pi$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际HasDerivWithinAt解关系；不计轨道存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.freeRigidSolution",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def freeRigidSolution (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) I t
```

### MD-4.4.1-RigidInvariants
```json
{
  "source_id": "MD-4.4.1-RigidInvariants",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "the Euler equations are in the form of a Hamiltonian system on a three-dimensional phase space. The symplectic structure matrix is dependent on the phase variables, and it is degenerate: $\\widetilde J\\pi=\\pi\\times\\pi=0$, signifying that total angular momentum is conserved: $\\|\\pi\\|=\\mathrm{constant}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidInvariants",
  "reusable_proofs": [],
  "extra_assumptions": [
    "对称正定T、实际连续闭区间轨道，证明原能量H̃=πᵀT⁻¹π/2和角动量平方同时守恒；不假设任一守恒。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rigidInvariants :
  ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) a b,
  T.PosDef → a ≤ b → ContinuousOn π (Icc a b) → MolecularDynamics.Chapter04Review.freeRigidSolution T π (Icc a b) →
    ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) ∧
      MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a)
```

### MD-4.4.1-RigidPoissonMatrix
```json
{
  "source_id": "MD-4.4.1-RigidPoissonMatrix",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "$\\dot\\pi=\\widetilde J(\\pi)\\nabla\\widetilde H$, where $\\widetilde J(\\pi)=\\operatorname{skew}(\\pi)$ is obviously skew symmetric, and $\\widetilde H=\\pi^TT^{-1}\\pi/2$ is the energy function.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实skewπ；退化与场恒等式另条，不假称Jacobi或全Poisson理论已验。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidPoissonMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rigidPoissonMatrix (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := MolecularDynamics.Chapter04Review.skewMatrix π
```

### MD-4.4.1-PoissonDegeneracy
```json
{
  "source_id": "MD-4.4.1-PoissonDegeneracy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "$\\widetilde J\\pi=\\pi\\times\\pi=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.poissonDegeneracy",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem poissonDegeneracy : ∀ π : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ π=0
```

