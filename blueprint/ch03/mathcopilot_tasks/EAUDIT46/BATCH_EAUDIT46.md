# EAUDIT46：第3章§3.6.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.6.3-TrapezoidalProperties",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.3",
  "printed_page": "131",
  "pdf_page": "153",
  "statement_latex": "A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条保留梯形关系在正确反转下可逆及一个真实Hamiltonian非辛步解反例；Symplectic Euler相邻反例单列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.trapezoidalProperties",
  "reusable_proofs": [],
  "extra_assumptions": [
    "完整实际隐式G与C¹Jacobian资格，不用求解存在作为结论前提。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT46_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:40:10.328476",
      "before_sha256": "b98434709f81240dc75df83f4385bf50bb833c39adb7244062c4d491138a5bc2",
      "after_sha256": "252c8cd527e8af5fc1aed7a06632d2b9b244c645c745768a2e31208efd77ec21",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT46/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem trapezoidalProperties :
  (∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) h z w,
    linearInvolution R → (∀ x, f (R x)=-R (f x)) → trapezoidalRelation f h z w →
    trapezoidalRelation f h (R w) (R z)) ∧
  ∃ (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ),
    ContDiff ℝ ∞ H ∧ ContDiff ℝ 1 (G h) ∧
    (∀ z, G h z=z+(h/2) • (textbookHamiltonianVectorField H z+textbookHamiltonianVectorField H (G h z))) ∧
    ¬ IsTextbookSymplecticMap (G h) := by
  sorry
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
### 实际依赖 MD.Ch03.linearInvolution
```lean
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
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
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```
### 实际依赖 MD.Ch03.trapezoidalRelation
```lean
def trapezoidalRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w=z+(h/2) • (f z+f w)
```
