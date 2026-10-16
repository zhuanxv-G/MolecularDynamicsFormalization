# EAUDIT46：第4章§4.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3-ConstraintSet",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "Constraints such as those described above define a manifold in the configuration space $\\mathcal M=\\{q\\mid g(q)=0\\}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constraintSet",
  "reusable_proofs": [],
  "extra_assumptions": [
    "定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。",
    "[EXTRA] 零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:57:09.937079",
      "before_sha256": "5b9fa63b38ada516a0db2fd84d8f0a57e165820cd63183b87bcc6967d4b61e5d",
      "after_sha256": "0a50905b46c803f3683604e6776c80d5ba596658d618679e3903ded1bf267b97",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT46_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:45:33.373516",
      "before_sha256": "0a50905b46c803f3683604e6776c80d5ba596658d618679e3903ded1bf267b97",
      "after_sha256": "5de56d43990526888872bb04c1676b2a3c6128a1304e1c66bdbcb39a4193c10a",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT46/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}

theorem constraintSet_regularLevel (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ∞ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ∞ φ A ∧ ContDiffOn ℝ ∞ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
  sorry
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
### 实际依赖 MD.Ch04.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}
```
