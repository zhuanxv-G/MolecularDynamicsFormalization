# EAUDIT53：第4章§4.3网站修复复审

## 原文JSON
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
    "[EXTRA]原假设的可检验充分条件：质量正且真实约束梯度线性独立；正定作为结论。",
    "[EXTRA] 仅为正质量/梯度独立推出正定的充分条件辅助；原句可解且唯一的完整乘子结论由MD-4.3-GramInvertible补全，原文不删。"
  ],
  "statement_scope": "仅约束Gram正定的EXTRA充分条件辅助；原句解乘子由MD-4.3-GramInvertible承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:58:11.914481",
      "before_sha256": "1dfce8199b76d56c783d1bba5bbbc6e2ecee179319e96f320e5eae880d8e3025",
      "after_sha256": "bdd90a95d89beb5470de06956a53e2fa77961f427cdd43a5c0376d5744e4f3f0",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem gramPositive {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).PosDef := by
  apply MolecularDynamics.textbookConstraintGram_posDef <;> assumption
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
```json
{
  "source_id": "MD-4.3-GramInvertible",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "153",
  "pdf_page": "175",
  "statement_latex": "Assuming $g'(q)M^{-1}g'(q)^T$ is invertible, we may solve for $\\lambda$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$q,p\\in\\mathbb R^{N_c}$ 为位置和动量；$M$ 为质量矩阵，$F(q)=-\\nabla U(q)$（PDF174/印刷152，(4.7)–(4.8)）。",
    "$g:\\mathbb R^{N_c}\\to\\mathbb R^l$ 汇集约束，$g\\prime(q)$ 为其 Jacobian，$\\lambda\\in\\mathbb R^l$ 为 Lagrange 乘子（PDF174/印刷152）。",
    "$\\varphi_k=p^TM^{-1}\\nabla^2g_k(q)M^{-1}p$，且 $g\\prime(q)M^{-1}[F-g\\prime(q)^T\\lambda]+\\varphi\\equiv0$（PDF175/印刷153，页首两个展示公式）。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.gramInvertible",
  "reusable_proofs": [
    "MolecularDynamics.textbookConstraintGram_det_ne_zero"
  ],
  "extra_assumptions": [
    "[EXTRA]质量正及梯度独立推出真实Gram det≠0；不是将该结论作为前提。",
    "[EXTRA] 保留原可逆性充分条件证明，补det≠0下反力乘子唯一可解及明确逆Gram公式；F和φ是给定线性方程数据，不把所求λ作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:58:11.914481",
      "before_sha256": "92398eda7b398e738fb7d43e850bd05a8bf60e72dd0febfbebd2e76e9000588b",
      "after_sha256": "1d9c78e00d2cf8de46821f3ac1b1285b7d877ff23d44fed021e533a1b1f78193",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem gramInvertible {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).det ≠ 0 := by
  apply MolecularDynamics.textbookConstraintGram_det_ne_zero <;> assumption

theorem gramInvertible_multiplier (n l : ℕ) (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q F : MolecularDynamics.Chapter04Review.Q n) (φ : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (textbookConstraintGram m g q).det ≠ 0) :
    (∃! lam : MolecularDynamics.Chapter04Review.Q l,
      textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ lam)+φ=0) ∧
    (∀ lam : MolecularDynamics.Chapter04Review.Q l,
      (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ lam)+φ=0) ↔
      lam=(textbookConstraintGram m g q)⁻¹ *ᵥ
        (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m F+φ)) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
```json
{
  "source_id": "MD-4.3-CotangentInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "153",
  "pdf_page": "175",
  "statement_latex": "Reinserting this expression for $\\lambda$ into (4.8) then gives a system of ordinary differential equations whose solutions, starting from a point on $T^*\\mathcal M$, will remain on $T^*\\mathcal M$ for all time. The co-tangent bundle becomes an invariant manifold of this ODE system. $\\lambda$ is defined at any time by the physical variables $q$ and $p$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$q,p\\in\\mathbb R^{N_c}$ 为位置和动量；$M$ 为质量矩阵，$F(q)=-\\nabla U(q)$（PDF174/印刷152，(4.7)–(4.8)）。",
    "$g:\\mathbb R^{N_c}\\to\\mathbb R^l$ 汇集约束，$g\\prime(q)$ 为其 Jacobian，$\\lambda\\in\\mathbb R^l$ 为 Lagrange 乘子（PDF174/印刷152）。",
    "$\\varphi_k=p^TM^{-1}\\nabla^2g_k(q)M^{-1}p$，且 $g\\prime(q)M^{-1}[F-g\\prime(q)^T\\lambda]+\\varphi\\equiv0$（PDF175/印刷153，页首两个展示公式）。",
    "$\\mathcal M=\\{q:g(q)=0\\}$；$T^*\\mathcal M=\\{(q,p):g(q)=0,\\ g\\prime(q)M^{-1}p=0\\}$（PDF174/印刷152）。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.cotangentInvariant",
  "reusable_proofs": [
    "MolecularDynamics.textbookConstrainedODE_cotangent_invariant_of_mass_and_independence"
  ],
  "extra_assumptions": [
    "给定闭区间实际ODE解、C²约束、正质量及沿解梯度独立；“for all time”仅在实际解定义区间，不声称任意长时域解存在。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:58:11.914481",
      "before_sha256": "049cf0767639149d90853ff884d15d87decbf2022c451755baf9a867740d6af2",
      "after_sha256": "1a2c6c94c1523b46378e9d4f290a863d3e0e17ba72f30dafd2e77b0b9243a71f",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem cotangentInvariant {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (F : (Fin Nc → ℝ) → Fin Nc → ℝ) (q p : ℝ → Fin Nc → ℝ) (τ : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hind : ∀ t ∈ Icc 0 τ, LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (q t)))
    (hq : ∀ t ∈ Icc 0 τ, HasDerivWithinAt q (textbookInverseMassMatrix m *ᵥ p t) (Icc 0 τ) t)
    (hp : ∀ t ∈ Icc 0 τ, HasDerivWithinAt p
      (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ F (q t) (p t)) (Icc 0 τ) t)
    (hpos₀ : ∀ j, γ j (q 0) = 0)
    (hhidden₀ : ∀ j, (fderiv ℝ (γ j) (q 0)) (textbookInverseMassMatrix m *ᵥ p 0) = 0) :
    ∀ t ∈ Icc 0 τ, ∀ j, γ j (q t) = 0 ∧
      (fderiv ℝ (γ j) (q t)) (textbookInverseMassMatrix m *ᵥ p t) = 0 := by
  apply MolecularDynamics.textbookConstrainedODE_cotangent_invariant_of_mass_and_independence <;> assumption
```
### 实际依赖 MolecularDynamics.textbookConstrainedReactionMultiplier
```lean
noncomputable def textbookConstrainedReactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)
```
### 实际依赖 MolecularDynamics.textbookConstraintCurvature
```lean
noncomputable def textbookConstraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
```json
{
  "source_id": "MD-4.3-ReducedFieldRegularity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "153",
  "pdf_page": "175",
  "statement_latex": "Reinserting this expression for $\\lambda$ into (4.8) then gives a system of ordinary differential equations",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$q,p\\in\\mathbb R^{N_c}$ 为位置和动量；$M$ 为质量矩阵，$F(q)=-\\nabla U(q)$（PDF174/印刷152，(4.7)–(4.8)）。",
    "$g:\\mathbb R^{N_c}\\to\\mathbb R^l$ 汇集约束，$g\\prime(q)$ 为其 Jacobian，$\\lambda\\in\\mathbb R^l$ 为 Lagrange 乘子（PDF174/印刷152）。",
    "$\\varphi_k=p^TM^{-1}\\nabla^2g_k(q)M^{-1}p$，且 $g\\prime(q)M^{-1}[F-g\\prime(q)^T\\lambda]+\\varphi\\equiv0$（PDF175/印刷153，页首两个展示公式）。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.reducedFieldRegularity",
  "reusable_proofs": [
    "MolecularDynamics.contDiffAt_textbookConstrainedPhaseVectorField_of_mass_and_independence"
  ],
  "extra_assumptions": [
    "[EXTRA]C³约束/C¹位置力、质量正、真实梯度独立给局部C¹场；是隐含正则性的独立补充，不冒充构造流存在。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:58:11.914481",
      "before_sha256": "899ad59e0defdceaf73e279b2a1d1f63ca8d25d17e33fbebee67a6605a9b6904",
      "after_sha256": "f77eeff86808e1ada57ded6c73d936b36b860b7aa563a70b3e1cafd374950d84",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem reducedFieldRegularity
    {Nc Mc : ℕ} (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (z : (Fin Nc → ℝ) × (Fin Nc → ℝ))
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) z.1)) :
    ContDiffAt ℝ 1 (textbookConstrainedPhaseVectorField m γ U) z := by
  apply MolecularDynamics.contDiffAt_textbookConstrainedPhaseVectorField_of_mass_and_independence <;> assumption
```
### 实际依赖 MolecularDynamics.textbookConstrainedPhaseVectorField
```lean
noncomputable def textbookConstrainedPhaseVectorField {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (z : (Fin Nc → ℝ) × (Fin Nc → ℝ)) : (Fin Nc → ℝ) × (Fin Nc → ℝ) :=
  (textbookInverseMassMatrix m *ᵥ z.2,
    textbookPotentialForce U z.1 - (textbookConstraintJacobian γ z.1)ᵀ *ᵥ
      textbookConstrainedReactionMultiplier m γ (textbookPotentialForce U) z.1 z.2)
```
### 实际依赖 MolecularDynamics.textbookConstrainedReactionMultiplier
```lean
noncomputable def textbookConstrainedReactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)
```
### 实际依赖 MolecularDynamics.textbookConstraintCurvature
```lean
noncomputable def textbookConstraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```
