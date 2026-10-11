# BATCH16 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.3.5-SHAKEPositionPrinted
```json
{
  "source_id": "MD-4.3.5-SHAKEPositionPrinted",
  "kind": "definition",
  "label": null,
  "section": "4.3.5",
  "printed_page": "161",
  "pdf_page": "183",
  "statement_latex": "In the presence of the constraint, we consider the scheme\n\\[q_{n+1}-2q_n+q_{n-1}=h^2M^{-1}F(q_n)-h^2g'(q_n)^T\\lambda_n,\\tag{4.25}\\]\n\\[g(q_{n+1})=0.\\tag{4.26}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "(4.25)约束反力未带M⁻¹；一般非标量对角质量不能任意吸收入λ。"
    }
  ],
  "lean_decl": "MD.Ch04.shakePositionPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def shakePositionPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b)-h^2 • ((textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### MD-4.3.5-SHAKEPositionMass
```json
{
  "source_id": "MD-4.3.5-SHAKEPositionMass",
  "kind": "definition",
  "label": null,
  "section": "4.3.5",
  "printed_page": "161",
  "pdf_page": "183",
  "statement_latex": "It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.shakePositionRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]质量一致位置式h²M⁻¹(F−Gᵀλ)，非原印刷(4.25)。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def shakePositionRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b-(textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### MD-4.3.5-SHAKEPhase
```json
{
  "source_id": "MD-4.3.5-SHAKEPhase",
  "kind": "definition",
  "label": null,
  "section": "4.3.5",
  "printed_page": "161",
  "pdf_page": "183",
  "statement_latex": "A natural choice is to consider the phase space formulation of the Störmer-Verlet method for $\\dot q=M^{-1}p,\\dot p=F(q)$, then replace $F$ by $F-g'(q)^T\\lambda$, resulting in\n\\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\tag{4.27}\\]\n\\[p_{n+1/2}=p_n+(h/2)F(q_n)-(h/2)g'(q_n)^T\\lambda_n,\\tag{4.28}\\]\n\\[p_{n+1}=p_{n+1/2}+(h/2)F(q_{n+1})-(h/2)g'(q_{n+1})^T\\lambda_{n+1}.\\tag{4.29}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "含真实位置约束分支；不声称隐藏约束成立或隐式分支存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.shakeRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def shakeRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho rhonew : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • (F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ rhonew)
```

### MD-4.3.5-RATTLE
```json
{
  "source_id": "MD-4.3.5-RATTLE",
  "kind": "definition",
  "label": null,
  "section": "4.3.5",
  "printed_page": "161",
  "pdf_page": "183",
  "statement_latex": "A method that automatically preserves both the constraint and hidden constraint is the RATTLE method [12] which consists of the following steps:\n\\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\tag{4.30}\\]\n\\[p_{n+1/2}=p_n+(h/2)F_n-(h/2)g'(q_n)^T\\lambda_n,\\tag{4.31}\\]\n\\[0=g(q_{n+1}),\\tag{4.32}\\]\n\\[p_{n+1}=p_{n+1/2}+(h/2)F_{n+1}-g'(q_{n+1})^T\\mu_{n+1},\\tag{4.33}\\]\n\\[0=g'(q_{n+1})M^{-1}p_{n+1}.\\tag{4.34}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整关系，包括两个不同乘子缩放；定义不计解存在证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rattleRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### MD-4.3.5-ConstrainedOrders
```json
{
  "source_id": "MD-4.3.5-ConstrainedOrders",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5",
  "printed_page": "161–162",
  "pdf_page": "183–184",
  "statement_latex": "The projected symplectic constrained method (4.20)–(4.24) is only first order accurate. We forego providing a detailed proof of this fact, but note that it could be demonstrated using standard methods [164]. There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedOrders",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量、C⁴数据、独立约束与真实光滑隐式解分支及紧区间；明确局部截断误差Euler O(h²)、RATTLE O(h³)。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem constrainedOrders :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E R : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3
```

### MD-4.3.5-RATTLESymplectic
```json
{
  "source_id": "MD-4.3.5-RATTLESymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5",
  "printed_page": "162",
  "pdf_page": "184",
  "statement_latex": "Moreover, the symplecticness of (4.30)–(4.34) may be demonstrated using a very similar approach to that used to demonstrate the symplectic condition for (4.20)–(4.24). Given the above discussion and derivation, the proof of symplecticness of the RATTLE method (4.30)–(4.34) is now a formality. For details refer to [229].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rattleSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际C¹分支、C²势与约束；完整真实拉回两形式，非把辛性作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rattleSymplectic :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (G : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 U → Differentiable ℝ G →
    Differentiable ℝ half → Differentiable ℝ rho → Differentiable ℝ μ →
    (∀ z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g, MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (G z) (half z) (rho z) (μ z)) →
    MolecularDynamics.Chapter04Review.restrictedSymplectic m g G
```

### MD-4.3.5-StaggeredConstraint
```json
{
  "source_id": "MD-4.3.5-StaggeredConstraint",
  "kind": "definition",
  "label": null,
  "section": "4.3.5",
  "printed_page": "162",
  "pdf_page": "184",
  "statement_latex": "the iterations generated by them can be related to the following staggered iteration\n\\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\tag{4.35}\\]\n\\[p_{n+1/2}=p_{n-1/2}+hF_n-hg'(q_n)^T\\widetilde\\lambda_n,\\tag{4.36}\\]\n\\[0=g(q_{n+1}),\\tag{4.37}\\]\nwhere, for SHAKE, $\\widetilde\\lambda_n=\\lambda_n$, while, in case of RATTLE, we must define $\\widetilde\\lambda_n=(\\lambda_n+\\mu_n)/2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原μ在(4.33)无h/2，而此处平均式有缩放疑点，固定n下相容半步对象另条。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p162的平均乘子需与p161(4.33)无h/2缩放一致；未将未经核定平均关系计为证明。"
    }
  ],
  "lean_decl": "MD.Ch04.staggeredConstraintRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def staggeredConstraintRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • MolecularDynamics.Chapter04Review.invMass m newHalf ∧ qnew ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### MD-4.3.5-SHAKERATTLEEquivalence
```json
{
  "source_id": "MD-4.3.5-SHAKERATTLEEquivalence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5",
  "printed_page": "162",
  "pdf_page": "184",
  "statement_latex": "Given an initial condition $(q_0^S,p_0^S)$ for the SHAKE discretization, we easily determine $\\lambda_0^S$ by taking a step. Then it follows that\n\\[p_{-1/2}=p_0-(h/2)F(q_0^S)-(h/2)g'(q_0^S)^T\\lambda_0^S,\\]\nby solving (4.29). Next we obtain $p_0^R$ by solving (4.33)–(4.34) with $n=-1$. Then the sequences generated using $(q_0^S,p_0^S)$ as the initial point for SHAKE and that generated using $(q_0^S,p_0^R)$ in RATTLE will have identical positions (the momenta can be made compatible by simply projecting the SHAKE momenta onto the constraints).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "展示初始p−1/2从(4.29)消元的反力符号需核；原句保持。"
    }
  ],
  "lean_decl": "MD.Ch04.shakeRattlePositions",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实两套关系、相容初始半动量、正质量和同一局部唯一投影分支；不假设位置序列相同。",
    "[EXTRA]位置约束上梯度线性独立，保证显式逆Gram投影有定义；旧命题此资格缺失，不静默忽略。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem shakeRattlePositions :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      LinearIndependent ℝ (fun j => textbookConstraintGradient (g j) q)) →
    (∀ q base : MolecularDynamics.Chapter04Review.Q n, ∀ eta nu : MolecularDynamics.Chapter04Review.Q l, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      MolecularDynamics.Chapter04Review.projectionResidual m g q base eta=0 → MolecularDynamics.Chapter04Review.projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhoS rhoR muR : ℕ → MolecularDynamics.Chapter04Review.Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, MolecularDynamics.Chapter04Review.rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1))
```

