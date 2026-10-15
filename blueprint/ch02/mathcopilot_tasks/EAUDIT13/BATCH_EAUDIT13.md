# EAUDIT13：第2章§2.3.7网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.3.7-Adjoint",
  "kind": "definition",
  "label": null,
  "section": "2.3.7",
  "printed_page": "81",
  "pdf_page": "103",
  "statement_latex": "Given any numerical integrator $\\mathcal G_h$, consider the map\n\\[\\mathcal G_h^\\dagger=\\mathcal G_{-h}^{-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_adjoint",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]方法G每个可用h为实际Equiv.Perm；只在负步可逆时定义伴随，不能宣称任意步映射天然可逆。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:16:33.518100",
      "before_sha256": "4b531db4dd9bf254954826b7d7f9d7a6e8b820ca4533b908c2906f1431d1d6ff",
      "after_sha256": "5b2af04df8b9d3df19a094f651c79bf50838a94969a9f1b31ea8fba246fdbd65",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
noncomputable def bp_adjoint {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```
### 实际依赖 MD.Ch02.bp_adjoint
```lean
noncomputable def bp_adjoint {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.7-FlowSelfAdjoint",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.7",
  "printed_page": "82",
  "pdf_page": "104",
  "statement_latex": "For the flow map $\\mathcal F_h$, we know that the inverse map is precisely $\\mathcal F_{-h}$, so $\\mathcal F_h^\\dagger=\\mathcal F_h$, i.e. the flow map is in the normal sense “self-adjoint,” i.e. symmetric.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.flowSelfAdjoint",
  "reusable_proofs": [
    "MolecularDynamics.textbookFlowMethod_isSelfAdjoint"
  ],
  "extra_assumptions": [
    "[EXTRA]给定全球Flow群；原文局部流若无全球存在，须在正负步都可用域解释，未宣称所有ODE有全球流。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:16:33.518100",
      "before_sha256": "c2c696d89b89ccea6e0d6f647e13c02e56464e2e7fe0afb33f516450b85b3c5e",
      "after_sha256": "3d780cf8031a6d71f30b921760b3e20a5051355de6c882e7fd8e2322b76e673d",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem flowSelfAdjoint {E : Type*} [TopologicalSpace E]
    (F : Flow ℝ E) : textbookAdjointMethod (textbookFlowMethod F) = textbookFlowMethod F
```
### 实际依赖 MolecularDynamics.textbookAdjointMethod
```lean
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```
### 实际依赖 MolecularDynamics.textbookFlowMethod
```lean
noncomputable def textbookFlowMethod {E : Type*} [TopologicalSpace E]
    (F : Flow ℝ E) (h : ℝ) : Equiv.Perm E :=
  (F.toHomeomorph h).toEquiv
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.7-BackwardEuler",
  "kind": "definition",
  "label": null,
  "section": "2.3.7",
  "printed_page": "82",
  "pdf_page": "104",
  "statement_latex": "The adjoint method is defined by\n\\[\\boldsymbol Z=\\boldsymbol z+hf(\\boldsymbol Z),\\]\nand where the first was explicit, the second is implicit (it is the so-called backward Euler method).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF第104页本句前的 first 指显式Euler：$\\boldsymbol Z=\\boldsymbol z+hf(\\boldsymbol z)$；second 指本条的隐式关系。",
    "审阅注：这里只给隐式关系，不宣称对所有f、h和起点均存在唯一解；此注不是原书引文。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_backwardEulerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:16:33.518100",
      "before_sha256": "61c0fdd632f080e7383a47e0e20e8cddb6ab281389fecdc2c9601b1589cbcc04",
      "after_sha256": "612716a1c5b43db1bf6c5622e526e302b005bfed0969737bc31fe7660aecc584",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
def bp_backwardEulerRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w = z + h • f w
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch02.bp_backwardEulerRelation
```lean
def bp_backwardEulerRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w = z + h • f w
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.7-AdjointSymplecticEuler",
  "kind": "definition",
  "label": null,
  "section": "2.3.7",
  "printed_page": "82",
  "pdf_page": "104",
  "statement_latex": "Its adjoint method has a similar structure:\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol p,\\tag{2.22}\\]\n\\[\\boldsymbol P=\\boldsymbol p+hF(\\boldsymbol Q).\\tag{2.23}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "其（Its）指PDF第102页（印刷第80页）的辛Euler：(2.18) $\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol P$，(2.19) $\\boldsymbol P=\\boldsymbol p+hF(\\boldsymbol q)$。",
    "同页机械Hamiltonian为 $H=\\boldsymbol p^TM^{-1}\\boldsymbol p/2+U(\\boldsymbol q)$，M为对角质量矩阵，$F(\\boldsymbol q)=-\\nabla_{\\boldsymbol q}U(\\boldsymbol q)$；小写q,p为初始位置、动量，大写Q,P为步后位置、动量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_adjointSymplecticEuler",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 本条显式正质量及U经典可微，并补原文(Q,P)两条坐标公式；原总化正式辅助Equiv保持，新增坐标陈述暂sorry。Mathlib Flow按用户标准含义直接采信，FlowSelfAdjoint只补材料复审。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:16:33.518100",
      "before_sha256": "c99075bf6e4e37b8c813a382dd2c7ecf55ec1bbd1eb01625d2b1e320e256e1a6",
      "after_sha256": "156c5b18df74ce57531f6dfa10463f6bf8f588cafe29a6b3cb3aea968739153a",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
noncomputable def bp_adjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h

theorem bp_adjointSymplecticEuler_coordinates {Nc : ℕ}
    (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U)
    (h : ℝ) (z : SymplecticCoordinates Nc) :
    (∀ i, (bp_adjointSymplecticEuler m hm U hU h z) (Sum.inl i) =
      z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i)) ∧
    (∀ i, (bp_adjointSymplecticEuler m hm U hU h z) (Sum.inr i) =
      z (Sum.inr i) - h * fderiv ℝ U
        (fun j ↦ z (Sum.inl j) + h*(m j)⁻¹*z (Sum.inr j)) (Pi.single i 1)) := by
  sorry
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch02.bp_adjointSymplecticEuler
```lean
noncomputable def bp_adjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h
```
### 实际依赖 MolecularDynamics.textbookAdjointMethod
```lean
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```
### 实际依赖 MolecularDynamics.textbookMomentumKickEquiv
```lean
noncomputable def textbookMomentumKickEquiv {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) : Equiv.Perm (SymplecticCoordinates Nc) where
  toFun := textbookMomentumKick F h
  invFun := textbookMomentumKick F (-h)
  left_inv := textbookMomentumKick_neg_cancel F h
  right_inv z := by simpa only [neg_neg] using textbookMomentumKick_neg_cancel F (-h) z
```
### 实际依赖 MolecularDynamics.textbookPositionDrift
```lean
noncomputable def textbookPositionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
```
### 实际依赖 MolecularDynamics.textbookPositionDriftEquiv
```lean
noncomputable def textbookPositionDriftEquiv {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) where
  toFun := textbookPositionDrift m h
  invFun := textbookPositionDrift m (-h)
  left_inv := textbookPositionDrift_neg_cancel m h
  right_inv z := by simpa only [neg_neg] using textbookPositionDrift_neg_cancel m (-h) z
```
### 实际依赖 MolecularDynamics.textbookPositionProjection
```lean
noncomputable def textbookPositionProjection (Nc : ℕ) :
    SymplecticCoordinates Nc →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i => ContinuousLinearMap.proj (Sum.inl i)
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookSymplecticEulerEquiv
```lean
noncomputable def textbookSymplecticEulerEquiv {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookPositionDriftEquiv m h * textbookMomentumKickEquiv (textbookPotentialForce U) h
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.7-AdjointInvolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.7",
  "printed_page": "82",
  "pdf_page": "104",
  "statement_latex": "the adjoint of the adjoint is the original method:\n\\[\\mathcal G_h^{\\dagger\\dagger}=[\\mathcal G_{-h}^\\dagger]^{-1}=[\\mathcal G_h^{-1}]^{-1}=\\mathcal G_h.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.adjointInvolution",
  "reusable_proofs": [
    "MolecularDynamics.textbookAdjointMethod_involutive"
  ],
  "extra_assumptions": [
    "实际可逆步方法族Equiv.Perm；负步及双逆确实存在。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:16:33.518100",
      "before_sha256": "d97e525eec4e3af6bcfb6f4aaa4e14f5e8ba262686bc8d7bd55958a352c13275",
      "after_sha256": "fab6bd08500d6ec23cdb0fe1bb0e4e3a2629c255272bfed296ac3ed09a4ba4ec",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH20_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem adjointInvolution {E : Type*} (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookAdjointMethod G) = G
```
### 实际依赖 MolecularDynamics.textbookAdjointMethod
```lean
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```
