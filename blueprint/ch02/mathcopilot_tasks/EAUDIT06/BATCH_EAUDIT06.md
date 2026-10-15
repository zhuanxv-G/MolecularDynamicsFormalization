# EAUDIT06：第2章§2.2.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.2.4-FirstIntegral",
  "kind": "definition",
  "label": null,
  "section": "2.2.4",
  "printed_page": "70",
  "pdf_page": "92",
  "statement_latex": "Recall that the condition for a given function $I:\\mathbb R^m\\to\\mathbb R$ to be a first integral is that\n\\[\\nabla I(\\boldsymbol z)\\cdot f(\\boldsymbol z)=\\sum_{j=1}^m\\frac{\\partial I}{\\partial z_j}(\\boldsymbol z)f_j(\\boldsymbol z)\\equiv 0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "条件在整个开放域D处处成立；I实际可微，f为给定向量场。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_firstIntegral",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:09:14.470041",
      "before_sha256": "fcce7e29bc066942c4954256406ba1c5ee20f07e42fee269c289e5dc5f717a94",
      "after_sha256": "1a2cbe5494a4f002bc8b5d55336961a5c5d645872e3218bf59f76649167f5368",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
def bp_firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  IsOpen D ∧ DifferentiableOn ℝ I D ∧ ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch02.bp_firstIntegral
```lean
def bp_firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  IsOpen D ∧ DifferentiableOn ℝ I D ∧ ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.4-IntegralPreserved",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.4",
  "printed_page": "70",
  "pdf_page": "92",
  "statement_latex": "It is important in this definition that this is an equivalence that holds everywhere (or at least in some open set in $\\mathbb R^m$), so the statement is not just that $I(\\boldsymbol z(t))=I(\\boldsymbol z(0))$ for some particular trajectory, but, moreover, $I$ is conserved for all nearby initial conditions. The flow map preserves the first integral, thus $I(\\mathcal F_t(\\boldsymbol z))\\equiv I(\\boldsymbol z)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.firstIntegralPreserved",
  "reusable_proofs": [],
  "extra_assumptions": [
    "开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:09:14.470041",
      "before_sha256": "7867e0aac0aadfc660609a64754f2f74f7144a22f8dad4979d02c9757cc72fb0",
      "after_sha256": "14fe04e4dcc252d15e8eb78bcde269dfe8095f6ff8aae67a58220aa6d1f8e9fa",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem firstIntegralPreserved :
  ∀ n (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) (γ : ℝ → Q n) a b,
    a ≤ b → DifferentiableOn ℝ I D → IsOpen D → firstIntegral I f D →
    MapsTo γ (Icc a b) D → solution f γ a b → ∀ t ∈ Icc a b, I (γ t) = I (γ a)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.firstIntegral
```lean
def firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0
```
### 实际依赖 MolecularDynamics.Chapter02Review.solution
```lean
def solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (γ : ℝ → E) (a b : ℝ) : Prop :=
  ∀ t ∈ Icc a b, HasDerivWithinAt γ (f (γ t)) (Icc a b) t
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.4-IntegralLipschitz",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.4",
  "printed_page": "71",
  "pdf_page": "93",
  "statement_latex": "Hence\n\\[|I(\\boldsymbol a)-I(\\boldsymbol b)|\\le\\|\\nabla I(\\boldsymbol z_*)\\|\\|\\boldsymbol a-\\boldsymbol b\\|.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "z_* 为前项均值公式中连接 a、b 的线段上的同一点；当前 integralPointwiseBound 签名登记该点态不等式并携带均值恒等式。下一句才引入开放域上的统一梯度上界 B。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.integralPointwiseBound",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:09:14.470041",
      "before_sha256": "4d860d190688baf482203cae3343fe7841adfd50316312ffabae4fb3477d501f",
      "after_sha256": "f152ba39a6e7a5eedfce42cc9f378e3156e212e1da50be650fe1dda5fba89403",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem integralPointwiseBound : ∀ n (I : EuclideanSpace ℝ (Fin n) → ℝ) (D : Set (EuclideanSpace ℝ (Fin n))) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b=(fderiv ℝ I c) (a-b) ∧
      |I a-I b| ≤ ‖fderiv ℝ I c‖*‖a-b‖
```
