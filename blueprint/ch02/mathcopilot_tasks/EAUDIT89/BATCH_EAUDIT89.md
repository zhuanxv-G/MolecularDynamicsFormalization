# EAUDIT89：第2章§2.4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.4.1-SymmetricEven",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "Self-adjoint, or symmetric schemes have unique features; in particular they have even order [164, 227].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.symmetricEven",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:20:34.172178",
      "before_sha256": "f8758a94060787b9daae351ed3b1926103129ea1d50c7db9a41688377549af35",
      "after_sha256": "2e802ae13be63a2448d0e0404f1acc5bbbf90f44dd243205f937e7d917d3b16e",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT49_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:21:30.155366",
      "before_sha256": "2e802ae13be63a2448d0e0404f1acc5bbbf90f44dd243205f937e7d917d3b16e",
      "after_sha256": "749bc2f5c88a434ea1d8e894bbfc0fbfb233976ad6e8fdf99ddf602d1f125136",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT49/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symmetricEven :
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.methodLocalOrder
```lean
def methodLocalOrder {E : Type*} [NormedAddCommGroup E]
    (G F : ℝ → E → E) (r : ℕ) : Prop :=
  ∀ z, ∃ C > 0, ∃ δ > 0, ∀ h : ℝ, |h| < δ → ‖G h z-F h z‖ ≤ C*|h|^(r+1)
```
### 实际依赖 MolecularDynamics.textbookAdjointMethod
```lean
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```
