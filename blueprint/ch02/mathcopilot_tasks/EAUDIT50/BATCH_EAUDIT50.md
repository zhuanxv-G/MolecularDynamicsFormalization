# EAUDIT50：第2章§2.5.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.5.1-ExplicitRK",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.1",
  "printed_page": "89",
  "pdf_page": "111",
  "statement_latex": "This method is not symplectic, and it is in fact impossible to find symplectic explicit methods within the Runge-Kutta family.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.explicitRK",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一致性∑bᵢ=1排除全零权重恒等映射；“不辛”解释为存在光滑Hamilton模型与实际阶段/步映射不辛，不宣称每个具体H均不辛。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:26:18.510671",
      "before_sha256": "8e4eb7844929520aadd22ab929aca8e27b9732dfb6eb60fa87ee282f6f2bb189",
      "after_sha256": "4c9d664f9d55de8dc1bb69c240569bf32f58f8dfea6b74c52d4e49c5660af714",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT50_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:29:25.859638",
      "before_sha256": "4c9d664f9d55de8dc1bb69c240569bf32f58f8dfea6b74c52d4e49c5660af714",
      "after_sha256": "3f408ae20576b59c8d364a645ae06dc510d0c98729ce2c6f157f841b5a48676f",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT50/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem explicitRK :
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ∃ (H : SymplecticCoordinates 1 → ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1)
      (stages : SymplecticCoordinates 1 → Fin s → SymplecticCoordinates 1) (h : ℝ),
      ContDiff ℝ ∞ H ∧ 0 < h ∧
      (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
        G z = z+h • ∑ i, b i • stages z i) ∧ ¬ IsTextbookSymplecticMap G := by
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
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```
