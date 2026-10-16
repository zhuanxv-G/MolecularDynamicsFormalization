# EAUDIT43：第3章§3.3.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.3.3-YoshidaRaiseOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.3",
  "printed_page": "109",
  "pdf_page": "131",
  "statement_latex": "giving us a scheme of order $2s+2$. We can then proceed recursively, as this new order $2s+2$ scheme can be composed similarly to wipe out successive higher order terms.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原方法对称且阶2s≥2，真实三步复合及系数同页；保留负时间步。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshidaRaiseOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "给定光滑场、G在(h,z)全域C∞、开放D与紧B、实际双向局部流、反步对称和局部阶；实际改阶是结论。",
    "[EXTRA] 将孤立B上的逐紧集阶改为D内每个紧集的一致阶资格，覆盖移动中间点；结论补新方法在每紧集升阶、光滑及对称，保留递归资格。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:16:24.137455",
      "before_sha256": "47675002c18a300ad35fea10d7b0556e95be59cc2f46e75fb28a6729cb239e67",
      "after_sha256": "f206b1f4c18e40fd01fdfd475cfea3d7c75dd40c33edc7f6bc97337a6efeb2cc",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT43_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:38:09.309129",
      "before_sha256": "f206b1f4c18e40fd01fdfd475cfea3d7c75dd40c33edc7f6bc97337a6efeb2cc",
      "after_sha256": "5a4eefce3171f54beacf3d8f5f0b8d1795dfe15c268803e24b5dbc938aadec46",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT43/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem yoshidaRaiseOrder :
  ∀ (n s : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    1 ≤ s → ContDiff ℝ ∞ f → ContDiff ℝ ∞ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η →
    (∀ h z, G (-h) (G h z)=z) → (∀ K : Set (Q n), IsCompact K → K ⊆ D → localOrder G Φ K (2*s)) →
    localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ B (2*s+2) ∧
    (∀ K : Set (Q n), IsCompact K → K ⊆ D →
      localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ K (2*s+2)) ∧
    (∀ h z, yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 (-h)
      (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 h z)=z) ∧
    ContDiff ℝ ∞ (fun hz : ℝ × Q n ↦
      yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 hz.1 hz.2) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter03Review.actualFlow
```lean
def actualFlow {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (D : Set E) (Φ : ℝ → E → E) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ D, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter03Review.localOrder
```lean
def localOrder {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G Φ : ℝ → E → E) (B : Set E) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
    ‖G h z-Φ h z‖ ≤ C*|h|^(r+1)
```
### 实际依赖 MD.Ch03.yoshidaCoefficients
```lean
def yoshidaCoefficients (s : ℕ) : ℝ × ℝ := (1/(2-yoshidaRoot s),-yoshidaRoot s/(2-yoshidaRoot s))
```
### 实际依赖 MD.Ch03.yoshidaCompose
```lean
def yoshidaCompose {E : Type*} (G : ℝ → E → E) (a b h : ℝ) : E → E := G (a*h) ∘ G (b*h) ∘ G (a*h)
```
### 实际依赖 MolecularDynamics.Chapter03Review.yoshidaRoot
```lean
def yoshidaRoot (s : ℕ) : ℝ := Real.rpow 2 (1/((2*s+1 : ℕ):ℝ))
```
