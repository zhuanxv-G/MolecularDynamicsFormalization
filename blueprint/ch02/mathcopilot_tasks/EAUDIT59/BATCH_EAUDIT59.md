# EAUDIT59：第2章§2.3.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.3.2-EulerVolumeCounterexample",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.2",
  "printed_page": "75",
  "pdf_page": "97",
  "statement_latex": "The conditions for volume preservation by the flow map and its Euler approximation are essentially unrelated. Thus Euler’s method does not in general conserve phase space volume (it conserves volume only in very special cases—see Exercise 6).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.eulerVolumeCounterexample",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_proved"
  ],
  "extra_assumptions": [
    "[EXTRA] 强化见证为每个h≠0时|det(I+hS)|≠1，覆盖实际体积不守恒；原桥接只给det≠1，原已证结果完整保留为det_only辅助定理并重查，强化结论暂sorry，不写新证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:11:05.455581",
      "before_sha256": "74abe5377dc3efd2c78649f97975c51ad9250d14996a823b04e8400301b5acdf",
      "after_sha256": "050cd1a81a05c232a16b4f3e036f4e12c643e8664d00f8759302d8d61a697fa3",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH14_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem eulerVolumeCounterexample :
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → |(linearEuler S h).det| ≠ 1 := by
  sorry

theorem eulerVolumeCounterexample_det_only :
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → (linearEuler S h).det ≠ 1 := by
  exact MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_proved
```
### 实际依赖 MolecularDynamics.Chapter02Review.linearEuler
```lean
def linearEuler {n : ℕ} (S : Matrix (Fin n) (Fin n) ℝ) (h : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  1 + h • S
```
