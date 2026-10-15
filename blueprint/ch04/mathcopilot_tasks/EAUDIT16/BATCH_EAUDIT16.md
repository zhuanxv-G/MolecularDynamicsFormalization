# EAUDIT16：第4章§4.3.6网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3.6-LINCSInverse",
  "kind": "definition",
  "label": null,
  "section": "4.3.6",
  "printed_page": "165",
  "pdf_page": "187",
  "statement_latex": "LINCS In solving the Eqs. (4.27)–(4.29) by Newton iteration, the largest cost and the most significant barrier to parallelization is the linear solve. The LINCS method [119, 175] uses a series expansion to approximate the inverse matrix (which is valid only under certain conditions).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.lincsInverse",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]标准Neumann有限和Σ(j=0..k) C^j表达series inverse，正文没有印系数公式；收敛条件另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:59:31.999109",
      "before_sha256": "5ec0ff086efb0a209d11763e48ca13a1812a11d8435cb29070ea7f80aa635ca0",
      "after_sha256": "9d4f3a79a30f6068ab706bf50653d007e579d49847d9de311fe89f0cb5a1a4be",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT16/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j
```
### 实际依赖 MD.Ch04.lincsInverse
```lean
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.6-LINCSConvergence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.6",
  "printed_page": "165",
  "pdf_page": "187",
  "statement_latex": "The LINCS method [119, 175] uses a series expansion to approximate the inverse matrix (which is valid only under certain conditions).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.lincsConvergence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确实际连续线性算子C.toLin'.toContinuousLinearMap的范数<1；不使用逐元素最大范数作为Neumann收敛资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:59:31.999185",
      "before_sha256": "d6dda24a3ac077fef1e3c02396a392ba9e6599e5a1a51e338cc17b6a95800a49",
      "after_sha256": "98140870eab33da20537f83303a659119d538d331e620a6accb8f8ebf1dede1c",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT16/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem lincsConvergence :
  ∀ l (C : Matrix (Fin l) (Fin l) ℝ),
  ‖C.toLin'.toContinuousLinearMap‖ < 1 → Tendsto (MolecularDynamics.Chapter04Review.lincsInverse C) atTop (𝓝 ((1-C)⁻¹)) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.lincsInverse
```lean
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j
```
### 实际依赖 MD.Ch04.lincsInverse
```lean
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j
```
