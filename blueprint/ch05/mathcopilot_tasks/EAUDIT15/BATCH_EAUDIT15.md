# EAUDIT15：第5章§5.3.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.3.2-WeakStationary",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "189–190",
  "pdf_page": "210–211",
  "statement_latex": "We are inclined to view the steady states (equilibrium solutions) of the Liouville equation as solutions of\n\\[\\mathcal L_f^\\dagger\\rho=0.\\]\nHowever, this requires a little care. In general, we would like to be able to apply $\\mathcal L_f^\\dagger$ to nonsmooth distributions such as Dirac delta functions for which the application of the Liouville operator does not make obvious sense (as we have not mentioned how to differentiate delta functions). Instead we will define the stationary solution in terms of integrals against test functions.\nthis suggests that the condition for the invariant probability density function $\\rho_\\infty$ should be\n\\[\\int_{\\mathcal D}\\phi\\mathcal L_f^\\dagger\\rho_\\infty\\,d\\omega=0,\\]\nfor all suitable functions $\\phi\\in C_0^\\infty(\\mathbb R^m)$. We say that $\\rho_\\infty$ satisfies\n\\[\\mathcal L^\\dagger\\rho_\\infty=0,\\]\nin the weak or variational sense.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal D\\subset\\mathbb R^m$ 为可容许相空间，$d\\omega=dz_1\\cdots dz_m$ 为 Lebesgue 体积元；$\\rho_\\infty$ 是待讨论的平稳概率分布或其密度。",
    "PDF p.211 在 “this suggests” 前的原文背景是 $\\partial\\rho/\\partial t=\\mathcal L_f^\\dagger\\rho$；本条摘录跨越 p.189–190 的不同段落。",
    "$C_0^\\infty(\\mathbb R^m)$ 是光滑紧支撑测试函数空间；对奇异测度，展示积分应按分布对偶理解。对受限测度的零延拓求分布导数时，边界贡献不能删除。",
    "原书末式为 $\\mathcal L^\\dagger\\rho_\\infty=0$，省略 f 下标；这里按原页保留，并不更换其所指算子。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.weakStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。",
    "[EXTRA] Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:58:05.599147",
      "before_sha256": "a1a447db25bf0f1d3c1e791ec30174f2c76eb079f2cd79181911d3c9ab8fadcb",
      "after_sha256": "e634d3d84adbb35e29b73fa3f086835de860f5eddf4883211c288f077314e5af",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:11:04.673565",
      "before_sha256": "e634d3d84adbb35e29b73fa3f086835de860f5eddf4883211c288f077314e5af",
      "after_sha256": "82ce6441d4aeb19724444dcbffd451e7bf808f6c7025c9bbf52c0e781b2da7b4",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.testSpace
```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}
```
### 实际依赖 MD.Ch05.weakStationary
```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```
