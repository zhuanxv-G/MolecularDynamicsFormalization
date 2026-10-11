# BATCH23 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4-RigidHamiltonian
```json
{
  "source_id": "MD-4.4-RigidHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170",
  "pdf_page": "192",
  "statement_latex": "The Hamiltonian is (for a single rigid body):\n\\[H_{\\rm RB}=\\frac{\\|p_{\\rm cm}\\|^2}{2M}+\\frac{\\operatorname{Tr}[\\Pi R^{-1}\\Pi^T]}2+U(q_{\\rm cm},\\Theta),\\]\nsubject to the orthogonality constraint $\\Theta^T\\Theta=I$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "M>0、R非奇异是物理资格；正交约束单列在真实ODE关系中；inverse定义不计存在理论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rigidHamiltonian (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q p : MolecularDynamics.Chapter04Review.V) (Θ mom : MolecularDynamics.Chapter04Review.Mat3) : ℝ :=
  MolecularDynamics.Chapter04Review.dot p p/(2*M)+(mom*R⁻¹*momᵀ).trace/2+U q Θ
```

### MD-4.4-SecondMomentDiagonal
```json
{
  "source_id": "MD-4.4-SecondMomentDiagonal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "By choosing an appropriate coordinate frame, it is possible to insure that the symmetric matrix $R$ is a diagonal matrix.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.secondMomentDiagonal",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem secondMomentDiagonal : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
    ∃ O : MolecularDynamics.Chapter04Review.Mat3, Oᵀ*O=1 ∧ ∀ i j, i ≠ j →
      (Oᵀ*MolecularDynamics.Chapter04Review.secondMoment m δ*O) i j=0
```

### MD-4.4-RotationBodyEnergy
```json
{
  "source_id": "MD-4.4-RotationBodyEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "It is convenient to express this in terms of the so-called body angular velocity $\\omega_b=\\Theta^T\\omega$ in which case it becomes $K_{\\rm rot}=\\frac12\\omega_b^TT\\omega_b$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationBodyEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实SO3旋转；不把动能等式/叉积协变当假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rotationBodyEnergy : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 →
  (∑ i, m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
    MolecularDynamics.Chapter04Review.rotationalEnergy (MolecularDynamics.Chapter04Review.inertiaTensor m δ) (Θᵀ *ᵥ «ω»)
```

### MD-4.4-DipolarConstraint
```json
{
  "source_id": "MD-4.4-DipolarConstraint",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170",
  "pdf_page": "192",
  "statement_latex": "The vectors $\\mu_k$ can be taken to be unit vectors reflecting the dipole orientation, so they are subject to the constraint $\\|\\mu_k\\|\\equiv1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Euclidean单位平方定义，与Pi最大范数不同。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.dipolarConstraint",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def dipolarConstraint {N : ℕ} (μ : Fin N → MolecularDynamics.Chapter04Review.V) : Prop :=
  ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1
```

### MD-4.4-DipolarPotentialSum
```json
{
  "source_id": "MD-4.4-DipolarPotentialSum",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170",
  "pdf_page": "192",
  "statement_latex": "$\\varphi^{\\rm dip}_{ij}=\\varphi^{\\rm LJ}(r_{ij})+\\mu_i^TL(q_{ij})\\mu_j$, with $U$ given as the sum of these over pairs.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.dipolarPotentialSum",
  "reusable_proofs": [],
  "extra_assumptions": [
    "对无重叠位置，真实Euclidean距离sqrtΣ(qi−qj)²及有限无序pair和；经验势定义，不计模拟正确性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def dipolarPotentialSum {N : ℕ} (lj : ℝ → ℝ) (q μ : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  ∑ i, ∑ j, if i < j then
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot (q i-q j) (q i-q j))) (q i-q j) (μ i) (μ j) else 0
```

### MD-4.4-RotationTrajectory
```json
{
  "source_id": "MD-4.4-RotationTrajectory",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "$\\delta_i(t)=\\Theta(t)\\delta_i(0)$, see Fig. 4.7, thus we have $\\dot\\delta_i=\\dot\\Theta\\delta_i(0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationTrajectory",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rotationTrajectory : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → HasDerivAt (fun s => Θ s *ᵥ δ) (d *ᵥ δ) t
```

### MD-4.4-RotationDerivativePrinted
```json
{
  "source_id": "MD-4.4-RotationDerivativePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "An alternative form for the rotational kinetic energy may be obtained by writing\n\\[\\dot\\delta_i=\\dot\\Theta\\delta_i(0)=\\dot\\Theta\\Theta^T\\Theta\\delta_i(0)=\\dot\\Theta\\Theta^T\\dot\\delta_i,\\]\nwhere we have used the fact that $\\Theta$ is orthogonal.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p168展示最后应以配置δ_i而非速度dotδ_i代换；已渲染视觉复核。"
    }
  ],
  "lean_decl": "MD.Ch04.rotationDerivativePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rotationDerivativePrinted : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → Θ t*(Θ t)ᵀ=1 →
    d *ᵥ δ=(d*(Θ t)ᵀ) *ᵥ (d *ᵥ δ)
```

