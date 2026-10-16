# EAUDIT90：第2章§2.4.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.4.2-CompositionSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.2",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "More generally, if we have any two symplectic numerical methods, say $\\mathcal G_h^1$ and $\\mathcal G_h^2$, then the composition\n\\[\\mathcal G_h:=\\mathcal G_{h/2}^1\\circ\\mathcal G_{h/2}^2\\]\nis another symplectic numerical method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.compositionSymplectic",
  "reusable_proofs": [
    "MolecularDynamics.textbookComposeMaps_isSymplectic"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:21:33.143846",
      "before_sha256": "40e5e3ca3b9ba17cd4883658b78b344af3351c08cc92c867d445798d07f23cec",
      "after_sha256": "07cabdd9ce3c3dc4e92251e202a037000dcec2b017dbe8ecac6d58f1af44f857",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT16/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem compositionSymplectic {Nc : ℕ}
    (G₁ G₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hG₁ : ∀ h, IsTextbookSymplecticMap (G₁ h))
    (hG₂ : ∀ h, IsTextbookSymplecticMap (G₂ h)) (h : ℝ) :
    IsTextbookSymplecticMap (textbookComposeMaps G₁ G₂ h) := by
  apply MolecularDynamics.textbookComposeMaps_isSymplectic <;> assumption
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
### 实际依赖 MolecularDynamics.textbookComposeMaps
```lean
noncomputable def textbookComposeMaps {E : Type*} (G₁ G₂ : ℝ → E → E) (h : ℝ) : E → E :=
  G₁ (h / 2) ∘ G₂ (h / 2)
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
