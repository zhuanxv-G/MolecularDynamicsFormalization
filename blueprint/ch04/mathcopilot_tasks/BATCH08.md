# BATCH08 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.3-FlexiblePendulumHamiltonian
```json
{
  "source_id": "MD-4.3-FlexiblePendulumHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "150",
  "pdf_page": "172",
  "statement_latex": "We suppose the restraint to have an associated coefficient $k=\\varepsilon^{-1}$, where $\\varepsilon$ is a small parameter. Then we have a generalized flexible pendulum with Hamiltonian $H=\\|p\\|^2/(2m)+U(q)+\\varepsilon^{-1}(\\|q\\|-r_0)^2/2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "欧氏Position3及欧氏norm，非Pi最大范数；m>0,ε>0为物理模型资格。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.flexiblePendulumHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def flexiblePendulumHamiltonian (m ε r₀ : ℝ) (U : Position 3 → ℝ)
    (z : Position 3 × Position 3) : ℝ :=
  ‖z.2‖^2/(2*m)+U z.1+ε⁻¹*(‖z.1‖-r₀)^2/2
```

### MD-4.3-RestraintPotential
```json
{
  "source_id": "MD-4.3-RestraintPotential",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "150",
  "pdf_page": "172",
  "statement_latex": "where the restraint potential $\\varphi_\\varepsilon(q)=\\varepsilon^{-1}(\\|q\\|-r_0)^2/2$ has associated restoring force",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实欧氏范数径向势；q=0处径向可微性需另核，不由定义冒充光滑。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.restraintPotential",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def restraintPotential (ε r₀ : ℝ) (q : Position 3) : ℝ :=
  ε⁻¹*(‖q‖-r₀)^2/2
```

### MD-4.3-RestraintForcePrinted
```json
{
  "source_id": "MD-4.3-RestraintForcePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "150",
  "pdf_page": "172",
  "statement_latex": "\\[F_\\varepsilon=-\\nabla\\varphi_\\varepsilon(q)=\\varphi'_\\varepsilon(q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "Fε=−∇φε=φ′ε的prime含义/负号待裁定；原文不静默更正。"
    }
  ],
  "lean_decl": "MD.Ch04.restraintForcePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]将prime暂按配置梯度解释；该记号解释待审。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem restraintForcePrinted :
    ∀ ε r₀ : ℝ, ∀ q : Position 3,
      -gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q =
       gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q
```

### MD-4.3-ConstrainedPendulum
```json
{
  "source_id": "MD-4.3-ConstrainedPendulum",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "151",
  "pdf_page": "173",
  "statement_latex": "The equations of motion for the constrained system take the form\n\\[\\dot q=v,\\qquad\\dot v=-\\nabla U(q)-q\\lambda,\\qquad0=\\|q\\|^2-r_0^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Gauss法向力Fc=−qλ由本关系保留；不将约束力唯一存在作已证结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedPendulum",
  "reusable_proofs": [],
  "extra_assumptions": [
    "原所写v′方程按单位质量，λ吸收法向grad(‖q‖²)=2q的因子；真实欧氏曲线和导数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def constrainedPendulum (U : Position 3 → ℝ) (r₀ : ℝ)
    (q v : ℝ → Position 3) (lam : ℝ → ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (v t) I t ∧
    HasDerivWithinAt v (-gradient U (q t)-(lam t) • q t) I t ∧
    ‖q t‖^2-r₀^2=0
```

### MD-4.3-ConstraintCurvature
```json
{
  "source_id": "MD-4.3-ConstraintCurvature",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "153",
  "pdf_page": "175",
  "statement_latex": "where $\\varphi$ is an $l$-dimensional vector whose $k$th component is\n\\[\\varphi_k=p(t)^TM^{-1}\\nabla_q^2g_k(q(t))M^{-1}p(t).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实D²g双线性作用在两个M⁻¹p上；不是任意给定曲率符号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.constraintCurvature",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def constraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)
```

### MD-4.3-ReactionMultiplier
```json
{
  "source_id": "MD-4.3-ReactionMultiplier",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "153",
  "pdf_page": "175",
  "statement_latex": "Using (4.8) in (4.10) we obtain\n\\[g'(q)M^{-1}[F-g'(q)^T\\lambda]+\\varphi=0.\\]\nThis is a system of linear equations for $\\lambda$. Assuming $g'(q)M^{-1}g'(q)^T$ is invertible, we may solve for $\\lambda$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "λ为真实Gram逆乘(GM⁻¹F+φ)；矩阵逆的语义资格det≠0在下一定理及Gram性质中明确。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.reactionMultiplier",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def reactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)
```

### MD-4.3-ReactionBalance
```json
{
  "source_id": "MD-4.3-ReactionBalance",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "153",
  "pdf_page": "175",
  "statement_latex": "Using (4.8) in (4.10) we obtain\n\\[g'(q)M^{-1}[F-g'(q)^T\\lambda]+\\varphi=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.reactionBalance",
  "reusable_proofs": [
    "MolecularDynamics.textbookConstrainedReaction_balance"
  ],
  "extra_assumptions": [
    "真实Gram det≠0；F=−grad U是Hamiltonian实例，一般位置力定理提供更强桥接。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem reactionBalance {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) (hdet : (textbookConstraintGram m γ q).det ≠ 0) :
    textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (F q - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookConstrainedReactionMultiplier m γ F q p)) +
        textbookConstraintCurvature m γ q p = 0
```

### MD-4.3-GramPositive
```json
{
  "source_id": "MD-4.3-GramPositive",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "153",
  "pdf_page": "175",
  "statement_latex": "Assuming $g'(q)M^{-1}g'(q)^T$ is invertible, we may solve for $\\lambda$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.gramPositive",
  "reusable_proofs": [
    "MolecularDynamics.textbookConstraintGram_posDef"
  ],
  "extra_assumptions": [
    "[EXTRA]原假设的可检验充分条件：质量正且真实约束梯度线性独立；正定作为结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gramPositive {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).PosDef
```

