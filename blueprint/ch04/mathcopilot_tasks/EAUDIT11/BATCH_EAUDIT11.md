# EAUDIT11：第4章§4.3.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3.2-NewtonQuadratic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.2",
  "printed_page": "157",
  "pdf_page": "179",
  "statement_latex": "When the solution is unique, the constraints sufficiently smooth, and the determinant of $R$ is bounded well away from zero, Newton’s method has a very rapid asymptotic convergence property. It is possible to show that, if $\\Lambda_*$ is the solution of (4.17), then sufficiently near the zero we have\n\\[\\|\\Lambda^{(l+1)}-\\Lambda_*\\|\\le C\\|\\Lambda^{(l)}-\\Lambda_*\\|^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.newtonQuadratic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "局部C²约束、真实残差root=0及真实R(root) det≠0；结论给存在邻域/二次界，不假设Newton误差结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:51.275819",
      "before_sha256": "420ba5cfe570cb14c03871bfc0bbee53a367425c1a2b10b5320731ffb098c344",
      "after_sha256": "9e8432a7a285837592185da1e898641f0f3fd2af63f2899a8282a97b789d9742",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT11_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:52:56.028825",
      "before_sha256": "9e8432a7a285837592185da1e898641f0f3fd2af63f2899a8282a97b789d9742",
      "after_sha256": "5fdb4584a3c25ff65bfb5c06b9e1497585f536fbb8ca49bf93bb6cc2bb77fc1e",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT11/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem newtonQuadratic :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base root).det ≠ 0 → ∃ C > 0, ∃ δ > 0,
    ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ → ‖MolecularDynamics.Chapter04Review.newtonConstraint m g q base η-root‖ ≤ C*‖η-root‖^2 := by
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
### 实际依赖 MolecularDynamics.Chapter04Review.newtonConstraint
```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  η+(projectionJacobian m g q base η)⁻¹ *ᵥ projectionResidual m g q base η
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectionJacobian
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  fun j => g j (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
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
### 实际依赖 MD.Ch04.newtonConstraint
```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (MolecularDynamics.Chapter04Review.projectionJacobian m g q base η).det ≠ 0) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base η)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η
```
### 实际依赖 MD.Ch04.projectionJacobian
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```
### 实际依赖 MD.Ch04.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
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
