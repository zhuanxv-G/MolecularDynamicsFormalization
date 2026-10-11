# BATCH18 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.3.5.1-AdjointEuler
```json
{
  "source_id": "MD-4.3.5.1-AdjointEuler",
  "kind": "definition",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "163",
  "pdf_page": "185",
  "statement_latex": "Now replace $h$ by $-h$ and then swap $Q$ with $q$ and $P$ with $p$, resulting in\n\\[\\widehat P=p-hg'(q)^T\\lambda,\\quad Q=q+hM^{-1}\\widehat P,\\quad P=\\widehat P+hF(Q)-hg'(Q)^T\\mu,\\]\nwhere $\\lambda,\\mu$ are again defined by the constraint conditions. This defines the adjoint method, another first order method for the constrained system.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实末位置/隐藏约束；原正h、乘子吸收缩放须h≠0。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.adjointEulerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### MD-4.3.5.1-ConstrainedComposition
```json
{
  "source_id": "MD-4.3.5.1-ConstrainedComposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "163",
  "pdf_page": "185",
  "statement_latex": "By composing the maps $G_{h/2}$ and $G^*_{h/2}$ we get a second order symplectic method. In the sense that it is defined by first order maps which reduce to the Symplectic Euler method and its adjoint, this is an analogous scheme to the Störmer-Verlet method. Interestingly, this method is not equivalent to SHAKE or RATTLE.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedComposition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "给定真实C¹半步分支、C²势与约束，前后位置约束；本条完整拉回形式结论，二阶精度另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem constrainedComposition :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoA μA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 3 (g j)) → ContDiff ℝ 3 U → (∀ i, 0 < m i) →
    (∀ h, Differentiable ℝ (E h) ∧ Differentiable ℝ (A h) ∧
      Differentiable ℝ (pE h) ∧ Differentiable ℝ (pA h) ∧ Differentiable ℝ (rhoE h) ∧
      Differentiable ℝ (μE h) ∧ Differentiable ℝ (rhoA h) ∧ Differentiable ℝ (μA h)) →
    (∀ h z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (μA h z)) →
    ∀ h, MolecularDynamics.Chapter04Review.restrictedSymplectic m g (A (h/2) ∘ E (h/2))
```

### MD-4.3.5.1-ConstrainedCompositionOrder
```json
{
  "source_id": "MD-4.3.5.1-ConstrainedCompositionOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "163",
  "pdf_page": "185",
  "statement_latex": "By composing the maps $G_{h/2}$ and $G^*_{h/2}$ we get a second order symplectic method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedCompositionOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实光滑隐式分支、正质量、C⁴势/约束和一致时间区间；实际局部O(h³)精度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem constrainedCompositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE muE rhoA muA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 3 (Function.uncurry E) → ContDiff ℝ 3 (Function.uncurry A) →
    (∀ z, E 0 z=z ∧ A 0 z=z ∧ muE 0 z=0) →
    (∀ h z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (muE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (muA h z)) →
    ∀ z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g, (textbookConstraintGram m g z.1).det ≠ 0 →
    ∀ Φ : ℝ → MolecularDynamics.Chapter04Review.Z n, ContDiff ℝ 3 Φ → Φ 0=z →
      (∃ d > 0, ∀ t ∈ Ioo (-d) d, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t) →
      ∃ C > 0, ∃ d > 0, ∀ h ∈ Ioo 0 d, ‖A (h/2) (E (h/2) z)-Φ h‖ ≤ C*h^3
```

### MD-4.3.5.1-MomentumProjector
```json
{
  "source_id": "MD-4.3.5.1-MomentumProjector",
  "kind": "definition",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "163",
  "pdf_page": "185",
  "statement_latex": "where $\\Pi$ is a mass-weighted projector onto the tangent space of the constraints at the point $q$ defined by\n\\[\\Pi=I-g'(q)^T[g'(q)M^{-1}g'(q)^T]^{-1}g'(q)M^{-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际作用于动量协向量；逆Gram需非奇异资格，未假装正交Euclidean投影。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.momentumProjector",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def momentumProjector {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q : MolecularDynamics.Chapter04Review.Q n) :=
  (1 : Matrix (Fin n) (Fin n) ℝ)-(textbookConstraintJacobian g q)ᵀ *
    (textbookConstraintGram m g q)⁻¹ * textbookConstraintJacobian g q * textbookInverseMassMatrix m
```

### MD-4.3.5.1-ConstrainedPotentialFlow
```json
{
  "source_id": "MD-4.3.5.1-ConstrainedPotentialFlow",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "163",
  "pdf_page": "185",
  "statement_latex": "For the potential energy term, an exact solution is given by $Q=q,\\quad P=p-h\\Pi(q)\\nabla U(q)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedPotentialFlow",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]签名采用真实Gram行列式非零、可微约束及初始余切约束；正质量和独立约束是通常物理资格的充分条件。只证势能子流的固定位置与投影动量ODE。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem constrainedPotentialFlow :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (z : MolecularDynamics.Chapter04Review.Z n),
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    (∀ j, Differentiable ℝ (g j)) → ∀ t : ℝ,
    let P := fun s : ℝ => z.2-s • (MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1)
    (z.1,P t) ∈ MolecularDynamics.Chapter04Review.cotangentSet m g ∧ HasDerivAt P (-MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1) t
```

### MD-4.3.5.1-GeodesicRelation
```json
{
  "source_id": "MD-4.3.5.1-GeodesicRelation",
  "kind": "definition",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "164",
  "pdf_page": "186",
  "statement_latex": "The constrained flow on the kinetic energy term, on the other hand, is generated by the equations of motion\n\\[\\frac{dq}{dt}=M^{-1}p,\\quad\\frac{dp}{dt}=-g'(q)^T\\lambda,\\quad0=g(q).\\]\nThis is nothing other than the mass-weighted geodesic flow on the given constraint surface.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际零势约束ODE；不搭建流形测地流存在理论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.geodesicRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def geodesicRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) : Prop :=
  MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ => 0) g q p rho I
```

