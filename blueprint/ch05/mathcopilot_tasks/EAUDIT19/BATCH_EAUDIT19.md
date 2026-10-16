# EAUDIT19：第5章§5.5网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.5-CenteredCorrelation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "205",
  "pdf_page": "226",
  "statement_latex": "So if either property has mean zero, then the absolute value of the autocorrelation function decays with time to zero.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "\\Sigma_E=\\{z:H(z)=E\\}; \\mathcal F_t 为动力学流。",
    "\\operatorname{Av}_{H=E}(g)=\\int_{\\Sigma_E}g(z)\\rho_E(z)\\,d\\omega；\\rho_E\\,d\\omega为参考微正则概率测度。",
    "C_{ab}(t)=k\\operatorname{Av}_{H=E}(a(\\mathcal F_t(z))\\cdot b(z))；a,b取值于同一Euclidean空间，k为归一化常数（PDF224–225）。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.centeredCorrelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]概率测度/有界连续资格，k仍保留；由实际混合相关式推导的绝对值结论，不只保留未中心化极限。",
    "[EXTRA] 扩至向量观测量、任意一向量Bochner零均值及相关绝对值趋零，保留旧标量证明辅助；不添加单调衰减。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:17:28.130216",
      "before_sha256": "97df576dbb0b3cb8cd081843994e48542e7f98888ddcff7636f04740a4a9e493",
      "after_sha256": "a8ca89f3bd592860993a3c081b504deff9d4cb4da4317366a536b21a8329bd0b",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem centeredCorrelation : ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k,IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) → weakMixing μ Φ →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  ((∫ z,a z ∂μ)=0 ∨ (∫ z,b z ∂μ)=0) →
  Tendsto (fun t => |k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)|) atTop (𝓝 0) := by
  sorry

theorem centeredCorrelation_scalar : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k,IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) → weakMixing μ Φ →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  (MolecularDynamics.Chapter05Review.average μ a=0 ∨ MolecularDynamics.Chapter05Review.average μ b=0) →
  Tendsto (fun t => |k*(∫ z,a (Φ t z)*b z ∂μ)|) atTop (𝓝 0) := by
  intro n μ Φ a b k hμ hΦ hm ha hb hba hbb hzero
  have ht := mixingCorrelation_scalar n μ Φ a b k hμ hΦ hm.2 ha hb hba hbb
  have hl : k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b=0 := by
    rcases hzero with h | h <;> rw [h] <;> ring
  rw [hl] at ht
  simpa only [abs_zero] using ht.abs
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.weakMixing
```lean
def weakMixing {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (IsProbabilityMeasure μ ∧ (∀ z,Φ 0 z=z) ∧
    (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) ∧ Measurable (Function.uncurry Φ)) ∧
  ∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
  Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))
```
