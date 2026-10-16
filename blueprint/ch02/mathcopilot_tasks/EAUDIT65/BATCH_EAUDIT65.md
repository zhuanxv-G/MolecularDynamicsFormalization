# EAUDIT65：第2章§2.4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.4.1-Splitting",
  "kind": "definition",
  "label": null,
  "section": "2.4.1",
  "printed_page": "83",
  "pdf_page": "105",
  "statement_latex": "Let $H(\\boldsymbol q,\\boldsymbol p)=H_1(\\boldsymbol q,\\boldsymbol p)+H_2(\\boldsymbol q,\\boldsymbol p)$ have flow map $\\mathcal F_h$, and indicate by $\\mathcal F_h^1,\\mathcal F_h^2$ the flow maps for the systems with Hamiltonians $H_1,H_2$, respectively. The proposal is that the map\n\\[\\mathcal G_h=\\mathcal F_h^1\\circ\\mathcal F_h^2\\]\nis an approximation of $\\mathcal F_h$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "只定义给定实际子流的组合；近似精度由后项给出，不把任意映射称为实际流。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_splittingMap",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:19:46.414902",
      "before_sha256": "36b43b98e7b04d926a75be3820b903e1ddc5c0574d69fa930ac8be3d19e64387",
      "after_sha256": "41abf2f7f1fafcb2c6ea11469fac974653a578878d62e45e17c5e018a3b7fdb8",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bp_splittingMap {E : Type*} (F₁ F₂ : ℝ → E → E) (h : ℝ) : E → E := F₁ h ∘ F₂ h
```
### 实际依赖 MD.Ch02.bp_splittingMap
```lean
def bp_splittingMap {E : Type*} (F₁ F₂ : ℝ → E → E) (h : ℝ) : E → E := F₁ h ∘ F₂ h
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.1-SplittingLocal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "83",
  "pdf_page": "105",
  "statement_latex": "For this to be a first order method, we need at least $\\|\\mathcal G_h(\\boldsymbol u)-\\mathcal F_h(\\boldsymbol u)\\|\\le C(\\boldsymbol u)h^2$.",
  "proof_latex": "Expand $\\mathcal F_h(\\boldsymbol u)$ in a Taylor series:\n\\[\\mathcal F_h(\\boldsymbol u)=\\boldsymbol u+hJ\nabla H+\\mathcal O(h^2)=\\boldsymbol u+h(J\nabla H_1+J\nabla H_2)+\\mathcal O(h^2).\\tag{2.24}\\]\nOn the other hand,\n\\[\\mathcal F_h^1(\\boldsymbol u)=\\boldsymbol u+hJ\nabla H_1(\\boldsymbol u)+\\mathcal O(h^2),\\qquad\\mathcal F_h^2(\\boldsymbol u)=\\boldsymbol u+hJ\nabla H_2(\\boldsymbol u)+\\mathcal O(h^2).\\]\nComposing the maps we have\n\\[\\mathcal F_h^1\\circ\\mathcal F_h^2(\\boldsymbol u)=\\boldsymbol u+hJ\nabla H_2(\\boldsymbol u)+hJ\nabla H_1(\\boldsymbol u+hJ\nabla H_2(\\boldsymbol u))+\\mathcal O(h^2).\\]\nAssuming $H_1$ is $C^2$, we have\n\\[\\mathcal F_h^1\\circ\\mathcal F_h^2(\\boldsymbol u)=\\boldsymbol u+h(J\nabla H_2(\\boldsymbol u)+J\nabla H_1(\\boldsymbol u))+\\mathcal O(h^2),\\]\nwhich agrees with the expansion (2.24) of the flow map through the terms of first order. Thus the splitting method does indeed provide a second order local approximation of the flow map.",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.splittingLocal",
  "reusable_proofs": [
    "MolecularDynamics.exists_hamiltonian_splitting_localError_bound"
  ],
  "extra_assumptions": [
    "实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:19:46.414902",
      "before_sha256": "f1e383c94d50722ca9de7c4a4e6c6a5f502a0a5af05819f9d387d039573535cc",
      "after_sha256": "bf174bdb16ddb8510dcb6934acd666a319e8efd2f11d7dd7041ecc0763f102b7",
      "changed_fields": [
        "proof_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem splittingLocal {Nc : ℕ}
    (D : Set (SymplecticCoordinates Nc)) (hD : IsOpen D)
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (hH₁ : ContDiffOn ℝ 2 H₁ D) (hH₂ : ContDiffOn ℝ 2 H₂ D)
    (F F₁ F₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (u : SymplecticCoordinates Nc) {τ : ℝ} (hτ : 0 ≤ τ)
    (hFD : ∀ t ∈ Icc 0 τ, F t u ∈ D)
    (hF₂D : ∀ t ∈ Icc 0 τ, F₂ t u ∈ D)
    (hF₁D : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, F₁ t (F₂ s u) ∈ D)
    (hF : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) (F t u)) (Icc 0 τ) t)
    (hF₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F₂ v u)
      (textbookHamiltonianVectorField H₂ (F₂ t u)) (Icc 0 τ) t)
    (hF₁ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, HasDerivWithinAt
      (fun v => F₁ v (F₂ s u)) (textbookHamiltonianVectorField H₁ (F₁ t (F₂ s u))) (Icc 0 τ) t)
    (hc : ContinuousOn (fun p : ℝ × ℝ => F₁ p.2 (F₂ p.1 u)) (Icc 0 τ ×ˢ Icc 0 τ))
    (hinit : F 0 u = u) (hinit₂ : F₂ 0 u = u)
    (hinit₁ : ∀ s ∈ Icc 0 τ, F₁ 0 (F₂ s u) = F₂ s u) :
    ∃ C : ℝ, 0 < C ∧
      (∀ h ∈ Icc 0 τ, ‖F₁ h (F₂ h u) - F h u‖ ≤ C * h ^ 2) ∧
      (0 < τ → Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
        (fun h => F₁ h (F₂ h u) - F h u) (fun h : ℝ => h ^ 2)) := by
  exact MolecularDynamics.exists_hamiltonian_splitting_localError_bound
    D hD H₁ H₂ hH₁ hH₂ F F₁ F₂ u hτ hFD hF₂D hF₁D hF hF₂ hF₁ hc hinit hinit₂ hinit₁
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.1-KineticFlow",
  "kind": "definition",
  "label": "Example 2.4 (kinetic)",
  "section": "2.4.1",
  "printed_page": "83–84",
  "pdf_page": "105–106",
  "statement_latex": "Let\n\\[H_1(\\boldsymbol q,\\boldsymbol p)=\\boldsymbol p^TM^{-1}\\boldsymbol p/2,\\qquad H_2(\\boldsymbol q,\\boldsymbol p)=U(\\boldsymbol q),\\]\nthen a splitting method for $H=H_1+H_2$ may be obtained by determining the flow maps for each of the two parts. For $H_1$ we have the differential equations\n\\[\\dot{\\boldsymbol q}=M^{-1}\\boldsymbol p,\\qquad\\dot{\\boldsymbol p}=\\boldsymbol0.\\]\nThe second equation tells us that $\\boldsymbol p$ is constant, so it is fixed at its initial value, whereas the first equation says that $\\boldsymbol q$ evolves on a linear path, hence its flow map is\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol p,\\qquad\\boldsymbol P=\\boldsymbol p.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "固定对角质量，mᵢ≠0资格由机械模型；闭式映射逐坐标表达。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_kineticFlow",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:19:46.414902",
      "before_sha256": "c08fe5d8e590cbc6a4afc475f7ab49c7b7f8e13971e68af96a2d437fdb25a1c0",
      "after_sha256": "1015e30957b256ceea570e068301f743a858b3bd9d54d86c7cd79d8be1e55648",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
noncomputable def bp_kineticFlow {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))

private noncomputable def momentumKickDerivative {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i) + h •
      (ContinuousLinearMap.proj i).comp
        ((fderiv ℝ F (textbookPositionProjection Nc z)).comp
          (textbookPositionProjection Nc))))

private theorem momentumKick_hasFDerivAt {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) :
    HasFDerivAt (textbookMomentumKick F h) (momentumKickDerivative F h z) z := by
  apply hasFDerivAt_pi.mpr
  intro i
  rcases i with i | i
  · exact hasFDerivAt_apply (Sum.inl i) z
  · have hf := ((hF.differentiable_one (textbookPositionProjection Nc z)).hasFDerivAt.comp z
      (textbookPositionProjection Nc).hasFDerivAt)
    have hi := (hasFDerivAt_apply i (F (textbookPositionProjection Nc z))).comp z hf
    simpa only [textbookMomentumKick, Sum.elim_inr, Pi.add_apply, Pi.smul_apply,
      Function.comp_apply, smul_eq_mul] using
      (hasFDerivAt_apply (Sum.inr i) z).fun_add (hi.fun_const_smul h)
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch02.bp_kineticFlow
```lean
noncomputable def bp_kineticFlow {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
```
### 实际依赖 MD.Ch02.momentumKickDerivative
```lean
private noncomputable def momentumKickDerivative {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i) + h •
      (ContinuousLinearMap.proj i).comp
        ((fderiv ℝ F (textbookPositionProjection Nc z)).comp
          (textbookPositionProjection Nc))))
```
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```
### 实际依赖 MolecularDynamics.textbookPositionProjection
```lean
noncomputable def textbookPositionProjection (Nc : ℕ) :
    SymplecticCoordinates Nc →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i => ContinuousLinearMap.proj (Sum.inl i)
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.1-PotentialFlow",
  "kind": "definition",
  "label": null,
  "section": "2.4.1",
  "printed_page": "84",
  "pdf_page": "106",
  "statement_latex": "Similarly, the flow map of the system with Hamiltonian $H_2=U$ is\n\\[\\boldsymbol Q=\\boldsymbol q,\\qquad\\boldsymbol P=\\boldsymbol p-h\nabla U(\\boldsymbol q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "F=-∇U；实际闭式映射。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_potentialFlow",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:19:46.414902",
      "before_sha256": "040b4dcd226289258bd06eb010961d3c5157182b2ecd377e5a6b76c171788db5",
      "after_sha256": "725116820e28f0413ef1782402ab6b60fc7b32475bef94db32e3080c9410e13b",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bp_potentialFlow {Nc : ℕ} (U : Q Nc → ℝ)
    (h : ℝ) : SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookMomentumKick (textbookPotentialForce U) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch02.bp_potentialFlow
```lean
def bp_potentialFlow {Nc : ℕ} (U : Q Nc → ℝ)
    (h : ℝ) : SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookMomentumKick (textbookPotentialForce U) h
```
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
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

## 原文JSON
```json
{
  "source_id": "MD-2.4.1-SplitEuler",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "84",
  "pdf_page": "106",
  "statement_latex": "The composition of these maps simplifies to\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol P,\\qquad\\boldsymbol P=\\boldsymbol p-h\nabla U(\\boldsymbol q),\\]\nwhich is precisely the Symplectic Euler method. Similarly, composing the same two maps in the opposite order gives the adjoint Symplectic Euler method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.splitEuler",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.kineticPotentialComposition_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:19:46.414902",
      "before_sha256": "5467dab516e1c6ffaa422c157c633664edb5c4c9e06629c644e9cf4651d63952",
      "after_sha256": "9f19b1fa093092c76c6b723c4507ddc3e68ffa1fee00a73eb72f6614997cc84e",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem splitEuler :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    splittingMap (textbookPositionDrift m) (textbookMomentumKick (textbookPotentialForce U)) h =
      textbookSymplecticEuler m U h ∧
    splittingMap (textbookMomentumKick (textbookPotentialForce U)) (textbookPositionDrift m) h =
      (fun z => textbookAdjointSymplecticEuler m U h z) := by
  exact MolecularDynamics.Chapter02Review.kineticPotentialComposition_proved
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.splittingMap
```lean
def splittingMap {E : Type*} (F₁ F₂ : ℝ → E → E) (h : ℝ) : E → E := F₁ h ∘ F₂ h
```
### 实际依赖 MolecularDynamics.textbookAdjointMethod
```lean
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```
### 实际依赖 MolecularDynamics.textbookAdjointSymplecticEuler
```lean
noncomputable def textbookAdjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h
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
### 实际依赖 MolecularDynamics.textbookSymplecticEuler
```lean
noncomputable def textbookSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h
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
  "source_id": "MD-2.4.1-VerletComposition",
  "kind": "unnumbered_claim",
  "label": "Example 2.5 (composition)",
  "section": "2.4.1",
  "printed_page": "84–85",
  "pdf_page": "106–107",
  "statement_latex": "For the Symplectic Euler method $\\mathcal G_h$ and its adjoint method $\\mathcal G_h^\\dagger$, consider the composition\n\\[\\mathcal K_h:=\\mathcal G_{h/2}^\\dagger\\circ\\mathcal G_{h/2}.\\]",
  "proof_latex": "Let\n\\[\\begin{bmatrix}\\bar{\\boldsymbol q}\\\\\\bar{\\boldsymbol p}\\end{bmatrix}=\\mathcal G_{h/2}\\begin{bmatrix}\\boldsymbol q\\\\\\boldsymbol p\\end{bmatrix},\\]\ni.e.,\n\\[\\bar{\\boldsymbol q}=\\boldsymbol q+(h/2)M^{-1}\\bar{\\boldsymbol p},\\qquad\\bar{\\boldsymbol p}=\\boldsymbol p-(h/2)\nabla U(\\boldsymbol q).\\]\nand set\n\\[\\begin{bmatrix}\\boldsymbol Q\\\\\\boldsymbol P\\end{bmatrix}=\\mathcal G_{h/2}^\\dagger\\begin{bmatrix}\\bar{\\boldsymbol q}\\\\\\bar{\\boldsymbol p}\\end{bmatrix},\\]\ni.e.,\n\\[\\boldsymbol Q=\\bar{\\boldsymbol q}+(h/2)M^{-1}\\bar{\\boldsymbol p},\\qquad\\boldsymbol P=\\bar{\\boldsymbol p}-(h/2)\nabla U(\\boldsymbol Q).\\]\nThe composition simplifies to\n\\[\\bar{\\boldsymbol p}=\\boldsymbol p-\\frac h2\nabla U(\\boldsymbol q),\\qquad\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\bar{\\boldsymbol p},\\qquad\\boldsymbol P=\\bar{\\boldsymbol p}-\\frac h2\nabla U(\\boldsymbol Q).\\]\nThis is just the leapfrog/Verlet method in its Hamiltonian form.",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.verletComposition",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.verletComposition_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:19:46.414902",
      "before_sha256": "9cc16bde6cf373626fb9a369826231cb9149ad6389c66e5c564e395c73952126",
      "after_sha256": "403eaa92e1a9bdb5e0606b573e751be75ef428bcae341b599f7f59aa4204cdab",
      "changed_fields": [
        "statement_latex",
        "proof_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem verletComposition :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    coordinateVerlet m (textbookPotentialForce U) h z =
      pack (verlet m (textbookPotentialForce U) h (unpack z)) ∧
    coordinateVerlet m (textbookPotentialForce U) h z =
      textbookAdjointSymplecticEuler m U (h/2) (textbookSymplecticEuler m U (h/2) z) := by
  exact MolecularDynamics.Chapter02Review.verletComposition_proved
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.coordinateVerlet
```lean
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.pack
```lean
def pack {n : ℕ} (z : Z n) : SymplecticCoordinates n := Sum.elim z.1 z.2
```
### 实际依赖 MolecularDynamics.textbookAdjointMethod
```lean
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```
### 实际依赖 MolecularDynamics.textbookAdjointSymplecticEuler
```lean
noncomputable def textbookAdjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h
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
### 实际依赖 MolecularDynamics.textbookSymplecticEuler
```lean
noncomputable def textbookSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h
```
### 实际依赖 MolecularDynamics.textbookSymplecticEulerEquiv
```lean
noncomputable def textbookSymplecticEulerEquiv {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookPositionDriftEquiv m h * textbookMomentumKickEquiv (textbookPotentialForce U) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.unpack
```lean
def unpack {n : ℕ} (z : SymplecticCoordinates n) : Z n := (z ∘ Sum.inl, z ∘ Sum.inr)
```
### 实际依赖 MolecularDynamics.Chapter02Review.verlet
```lean
def verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.1-VerletSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "Since we have obtained the method as the composition of two symplectic maps, and the symplectic maps form a group, we know that this method will also be symplectic.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.verletSymplectic",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.verletSymplectic_proved"
  ],
  "extra_assumptions": [
    "U C²；真实完整步映射。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:19:46.414902",
      "before_sha256": "f6dd866dbdb1ae2a339fb7e23fe40eb7b594dc76ed3177e07dda3b8e6f6c723a",
      "after_sha256": "063a4814dc32328ed5f10c5157bda0bd6740f26dafca87b2e993afc539453ba2",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem verletSymplectic :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h, ContDiff ℝ 2 U →
    IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) := by
  exact MolecularDynamics.Chapter02Review.verletSymplectic_proved
```
### 实际依赖 MolecularDynamics.IsTextbookSymplectic
```lean
def IsTextbookSymplectic {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) : Prop :=
  Aᵀ * textbookJ Nc * A = textbookJ Nc
```
### 实际依赖 MolecularDynamics.IsTextbookSymplecticMap
```lean
def IsTextbookSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.coordinateVerlet
```lean
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```
### 实际依赖 MolecularDynamics.textbookPositionDrift
```lean
noncomputable def textbookPositionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
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

## 原文JSON
```json
{
  "source_id": "MD-2.4.1-SymmetricComposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "When we construct a composition of a method with its adjoint method, we see readily that it is symmetric, i.e. self-adjoint, since\n\\[\\mathcal K_h^{\\dagger}:=[\\mathcal G_{h/2}^{\\dagger}\\circ\\mathcal G_{h/2}]^{\\dagger}=\\mathcal G_{h/2}^{\\dagger}\\circ\\mathcal G_{h/2}=\\mathcal K_h.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.symmetricComposition",
  "reusable_proofs": [
    "MolecularDynamics.textbookSymmetricComposition_isSelfAdjoint"
  ],
  "extra_assumptions": [
    "实际可逆步Equiv.Perm；完整伴随半步组合。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:19:46.414902",
      "before_sha256": "57ccc301c583573ff7fc71a0d1f645e5d3f0f13697c9a48053a328d1633305b1",
      "after_sha256": "eeee015739db88391b33ecf96e027d229441d6c28f2a04667104a54737055802",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symmetricComposition {E : Type*}
    (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookSymmetricComposition G) =
      textbookSymmetricComposition G := by
  apply MolecularDynamics.textbookSymmetricComposition_isSelfAdjoint <;> assumption
```
### 实际依赖 MolecularDynamics.textbookAdjointMethod
```lean
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```
### 实际依赖 MolecularDynamics.textbookComposeMethods
```lean
noncomputable def textbookComposeMethods {E : Type*} (G₁ G₂ : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := G₁ (h / 2) * G₂ (h / 2)
```
### 实际依赖 MolecularDynamics.textbookSymmetricComposition
```lean
noncomputable def textbookSymmetricComposition {E : Type*} (G : ℝ → Equiv.Perm E) :
    ℝ → Equiv.Perm E := textbookComposeMethods (textbookAdjointMethod G) G
```
