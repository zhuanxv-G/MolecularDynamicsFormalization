# EAUDIT51：第4章§4.2.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.2.2-MollifiedPotential",
  "kind": "definition",
  "label": null,
  "section": "4.2.2",
  "printed_page": "149",
  "pdf_page": "171",
  "statement_latex": "Effectively, one replaces $U_S(q)$ wherever it appears within the MTS method by a modified potential function $\\overline U(q)\\stackrel{\\mathrm{def}}=U_S(\\mathcal A(q))$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际US∘A；前条原页加权构造分开，不将def当滤波性能定理。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.mollifiedPotential",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:56:00.104282",
      "before_sha256": "3a403a72e3b5236d7394e007d06845e28324f9b23cc315b588ac4e96228a0c7a",
      "after_sha256": "4589d4398d07e1085ad65b347d8fdac9fa3a8bf854f980256086b459ee9e6ca1",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH06_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def mollifiedPotential {n : ℕ} (US : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) := US ∘ A
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.mollifiedPotential
```lean
def mollifiedPotential {n : ℕ} (US : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) := US ∘ A
```
