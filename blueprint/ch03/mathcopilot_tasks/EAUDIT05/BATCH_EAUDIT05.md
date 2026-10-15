# EAUDIT05：第3章§3.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.2-PoissonJacobi",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "Jacobi identity $\\{g_1,\\{g_2,g_3\\}\\}+\\{g_3,\\{g_1,g_2\\}\\}+\\{g_2,\\{g_3,g_1\\}\\}=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": "The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables).",
  "context_notation": [
    "同页三个smooth scalar-valued函数；非任意未微分函数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonJacobi",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_jacobi"
  ],
  "extra_assumptions": [
    "显式各函数在z为C²；真实二阶导数对称性支持Jacobi。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:02:37.900044",
      "before_sha256": "70289abb3d895c372ff744518fe38678ee326dd4396b2647b1685a0edcfbf2c9",
      "after_sha256": "996f564fa082861f17c3a50e458a2297cfea38032d62143405ab989d207ddf69",
      "changed_fields": [
        "proof_discussion_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem poissonJacobi (F G H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (hH : ContDiffAt ℝ 2 H z) :
    textbookPoissonBracket F (textbookPoissonBracket G H) z +
      textbookPoissonBracket H (textbookPoissonBracket F G) z +
      textbookPoissonBracket G (textbookPoissonBracket H F) z = 0
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
### 实际依赖 MD.Ch03.textbookPoissonBracket
```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
```

## 原文JSON
```json
{
  "source_id": "MD-3.2-HamiltonianLie",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "As a consequence, we have the following relation between the Lie derivative and the Poisson bracket:\n\\[\\mathcal L_{J\\nabla H}F\\equiv \\{F,H\\}.\\]\nFor a Hamiltonian flow, we typically simplify notation by writing $\\mathcal L_H$ in place of $\\mathcal L_{J\\nabla H}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal L_H=\\mathcal L_{J\\nabla H}$仅记号，旧CH03-025合并于此；实际hamiltonianLie定义亦为此。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianLie_eq_poisson",
  "reusable_proofs": [
    "MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:02:37.900044",
      "before_sha256": "8d24aa7536a3f2c36fde213183769450fbd9dc5f6f9dbbbddc3526d7aa0f1f5c",
      "after_sha256": "3ddcce4fe1e389b22c6e22054f21996ad44b2ab89e7ff924c3a9be78bfdeaec9",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem hamiltonianLie_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H
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
### 实际依赖 MD.Ch03.textbookLieDerivative
```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```
### 实际依赖 MD.Ch03.textbookPoissonBracket
```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
```
