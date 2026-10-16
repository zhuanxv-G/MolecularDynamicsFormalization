# EAUDIT66：第3章§3.7.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.7.3-ModifiedCollisionProjection",
  "kind": "definition",
  "label": null,
  "section": "3.7.3",
  "printed_page": "136",
  "pdf_page": "158",
  "statement_latex": "In particular, one may use the backward error analysis to obtain a modified Hamiltonian $\\widetilde H_h$ corresponding to the Verlet method with stepsize $h$, then to project during collisions not onto the energy surface, but onto the modified energy surface, so that\n\\[\\widetilde H_h\\equiv\\mathrm{const}.\\]\n(In practice, a low order approximation of $\\widetilde H_h$ is used, such as the truncation to terms of order four or six in the stepsize.)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原书实际使用有限截断；关系只要求起点终点有同一截断值，不证明投影存在/唯一、不供应BEA或统计准确。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.modifiedCollisionProjection",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:33:32.430543",
      "before_sha256": "9aa0f7520efe36efe9f59e762105eff41c9f55a7c6e83ab5c613959b2deae3fb",
      "after_sha256": "ad482d5aada0a4f4dcbbea8737e2a94cd2aba0e5e3e6a6b57ec647ac9a6be19f",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH26_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def modifiedCollisionProjection {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ) (h : ℝ)
    (z w : SymplecticCoordinates n) : Prop :=
  textbookTruncatedHamiltonian H Hj r k h w=textbookTruncatedHamiltonian H Hj r k h z
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch03.modifiedCollisionProjection
```lean
def modifiedCollisionProjection {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ) (h : ℝ)
    (z w : SymplecticCoordinates n) : Prop :=
  textbookTruncatedHamiltonian H Hj r k h w=textbookTruncatedHamiltonian H Hj r k h z
```
### 实际依赖 MolecularDynamics.textbookTruncatedHamiltonian
```lean
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```
