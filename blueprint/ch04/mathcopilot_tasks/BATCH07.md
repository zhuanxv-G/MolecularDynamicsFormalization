# BATCH07 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.3-HolonomicRelation
```json
{
  "source_id": "MD-4.3-HolonomicRelation",
  "kind": "definition",
  "label": "(4.3)",
  "section": "4.3",
  "printed_page": "150",
  "pdf_page": "172",
  "statement_latex": "In this section we consider holonomic constraints which may be expressed in terms of positions only, and perhaps time, i.e.\n\\[g(q,t)=0.\\tag{4.3}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "g的真实位置/时间函数；不同于任意独立动量约束。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.holonomicRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def holonomicRelation {n l : ℕ} (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) : Prop :=
  ∀ t, g (q t) t=0
```

### MD-4.3-TimeConstraintDerivative
```json
{
  "source_id": "MD-4.3-TimeConstraintDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "150",
  "pdf_page": "172",
  "statement_latex": "Note that by differentiating (4.3) with respect to time, we obtain $\\nabla_q g(q,t)\\cdot\\dot q+\\partial g/\\partial t=0$ which involves velocities.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.timeConstraintDerivative",
  "reusable_proofs": [],
  "extra_assumptions": [
    "g的实际uncurry可微、真实曲线导数q′=v、在当前时刻邻域g(q(s),s)=0；不把导数等于0作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem timeConstraintDerivative :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) t v,
    DifferentiableAt ℝ (Function.uncurry g) (q t,t) → HasDerivAt q v t →
    (∀ᶠ s in 𝓝 t, g (q s) s=0) → (fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)=0
```

### MD-4.3-ConstrainedSolution
```json
{
  "source_id": "MD-4.3-ConstrainedSolution",
  "kind": "definition",
  "label": "(4.4)–(4.9)",
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "the equations of motion may be written\n\\[\\dot q=M^{-1}p,\\tag{4.4}\\]\n\\[\\dot p=-\\nabla U(q)-\\sum_{k=1}^l\\lambda_k\\nabla g_k(q),\\tag{4.5}\\]\n\\[0=g_j(q),\\quad j=1,2,\\ldots,l.\\tag{4.6}\\]\nthen we may write the constrained equations of motion in the form\n\\[\\dot q=M^{-1}p,\\tag{4.7}\\qquad\\dot p=-\\nabla U(q)-g'(q)^T\\lambda,\\tag{4.8}\\qquad0=g(q).\\tag{4.9}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "F=−grad U代入所给一般位置力定义；实际各时刻导数和逐分量约束，不假定λ存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedSolution",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### MD-4.3-ConstraintSet
```json
{
  "source_id": "MD-4.3-ConstraintSet",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "Constraints such as those described above define a manifold in the configuration space $\\mathcal M=\\{q\\mid g(q)=0\\}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constraintSet",
  "reusable_proofs": [],
  "extra_assumptions": [
    "定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}
```

### MD-4.3-CotangentSet
```json
{
  "source_id": "MD-4.3-CotangentSet",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "The set of pairs $(q,p)$ satisfying, simultaneously, the equations\n\\[g(q)=0,\\qquad g'(q)M^{-1}p=0,\\]\nis called the co-tangent bundle associated to the manifold $\\mathcal M$, and we refer to it as $T^*\\mathcal M$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实约束Jacobian和质量逆作用；以嵌入相空间集合实现，不伪称已构造抽象余切丛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.cotangentSet",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量及独立梯度为几何解释资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Z n) :=
  {z | z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0}
```

### MD-4.3-ConstraintJacobian
```json
{
  "source_id": "MD-4.3-ConstraintJacobian",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "It is often convenient to combine all the constraints and to describe them by a single vector-valued function $g:\\mathbb R^{N_c}\\to\\mathbb R^l$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "g′由各真实Fréchet偏导组成，原页方程(4.8)的Jacobian对象。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.constraintJacobian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def constraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```

### MD-4.3-JacobianActualDerivative
```json
{
  "source_id": "MD-4.3-JacobianActualDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "Given a motion $(q(t),p(t),\\lambda(t))$ of (4.7)–(4.9) we note that $g(q(t))\\equiv0$ at all times $t$, hence, by differentiation\n\\[g'(q(t))\\dot q(t)\\equiv0,\\]\nwhich we may rephrase as\n\\[g'(q(t))M^{-1}p(t)\\equiv0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.jacobianActualDerivative",
  "reusable_proofs": [
    "MolecularDynamics.textbookConstraintJacobian_eq_actualDerivative"
  ],
  "extra_assumptions": [
    "[EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem jacobianActualDerivative {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hγ : ∀ j, DifferentiableAt ℝ (γ j) q) :
    textbookConstraintJacobian γ q =
      LinearMap.toMatrix' (fderiv ℝ (fun y j => γ j y) q).toLinearMap
```

### MD-4.3-ConstraintDegrees
```json
{
  "source_id": "MD-4.3-ConstraintDegrees",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "151",
  "pdf_page": "173",
  "statement_latex": "Note that with $l$ constraints the actual number of degrees of freedom, which is needed for things like the computation of temperature, is $N_d=N_c-l$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constraintDegrees",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实约束导数满射、当前点可微；独立正则约束下切空间是ker Dg，维数关系不作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem constraintDegrees :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l) (q : MolecularDynamics.Chapter04Review.Q n), DifferentiableAt ℝ g q →
    Function.Surjective (fderiv ℝ g q) →
    Module.finrank ℝ (LinearMap.ker (fderiv ℝ g q).toLinearMap)+l=n
```

