# EAUDIT37：第2章§2.3.5网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.3.5-ChainRule",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.5",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "Let $\\Phi_1$ and $\\Phi_2$ be any pair of symplectic maps. Then\n\\[(\\Phi_1\\circ\\Phi_2)'=\\Phi_1'\\Phi_2',\\]\nby the chain rule,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\Phi_1,\\Phi_2$ 是辛映射；撇号表示映射的 Jacobian。原书省略导数取值点；外导数取值于 $\\Phi_2(z)$ 是链式法则的解释，并非原文新增公式。",
    "辛映射在 PDF 第100页（印刷78页）定义为保持辛2形式的映射，坐标条件为 $\\Phi^{\\prime T}J\\Phi^\\prime=J$（2.17）。"
  ],
  "issues": [
    {
      "code": "OMITTED_EVALUATION_POINT",
      "status": "NEEDS_HUMAN",
      "detail": "原文Φ₁′Φ₂′未写外导数的Φ₂(z)取值点；Lean用正确链式法则，需审校确认简写约定。"
    }
  ],
  "lean_decl": "MD.Ch02.chainRule",
  "reusable_proofs": [
    "MolecularDynamics.textbookJacobian_comp"
  ],
  "extra_assumptions": [
    "两个实际映射在相应点可微；外导数在Φ₂(z)取值，原文简写省略底点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT11_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:14:51.635235",
      "before_sha256": "8dab3a87da555b06f844450e241cc54e9900294d98e6c0d6393f7c978515308e",
      "after_sha256": "26e925f9d79d14410318037ae137589ef81dd8f75855c0208d1acb5f1872cc03",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT11/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem chainRule {Nc : ℕ}
    (Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : Differentiable ℝ Φ) (hΨ : Differentiable ℝ Ψ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (Φ ∘ Ψ) z = textbookJacobian Φ (Ψ z) * textbookJacobian Ψ z := by
  apply MolecularDynamics.textbookJacobian_comp <;> assumption
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.5-SymplecticComposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.5",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "Thus the composition of any pair of symplectic maps is a symplectic map.",
  "proof_latex": null,
  "proof_note": "原书在结论前给出链式法则和保持辛矩阵的连续等式推导，无独立编号证明；推导记录于 proof_discussion_latex。",
  "proof_discussion_latex": "By the chain rule, hence\n\\[[(\\Phi_1\\circ\\Phi_2)^\\prime]^T J(\\Phi_1\\circ\\Phi_2)^\\prime=[\\Phi_1^\\prime\\Phi_2^\\prime]^T J\\Phi_1^\\prime\\Phi_2^\\prime=\\Phi_2^{\\prime T}\\Phi_1^{\\prime T}J\\Phi_1^\\prime\\Phi_2^\\prime=\\Phi_2^{\\prime T}J\\Phi_2^\\prime=J.\\]",
  "context_notation": [
    "$\\Phi_1,\\Phi_2$ 为前段任意辛映射；撇号表示 Jacobian，$T$ 表示转置，$J$ 为辛2形式的矩阵，满足（2.17）。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.symplecticComposition",
  "reusable_proofs": [
    "MolecularDynamics.IsTextbookSymplecticMap.comp"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT11_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:14:51.636254",
      "before_sha256": "10ffe19807c7e84baa23fc1c205bbf219d8155e6bb94c4f99d4d8c4a94672944",
      "after_sha256": "464a1ac9545205306d351364efb5a5d3d8ba3d8511a4b7cdce1fcfd60142112e",
      "changed_fields": [
        "proof_note",
        "proof_discussion_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT11/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticComposition {Nc : ℕ}
    {Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc}
    (hΦ : IsTextbookSymplecticMap Φ) (hΨ : IsTextbookSymplecticMap Ψ) :
    IsTextbookSymplecticMap (Φ ∘ Ψ) := by
  apply MolecularDynamics.IsTextbookSymplecticMap.comp <;> assumption
```
### 实际依赖 MolecularDynamics.IsTextbookSymplectic
```lean
def IsTextbookSymplectic {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) : Prop :=
  Aᵀ * textbookJ Nc * A = textbookJ Nc
```
### 实际依赖 MolecularDynamics.IsTextbookSymplecticMap
```lean
def IsTextbookSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.5-SymplecticInverse",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.5",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "and the inverse of a symplectic map is symplectic since $\\Phi'^TJ\\Phi'=J$ implies $J=\\Phi'^{-T}J\\Phi'^{-1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\Phi$ 为辛映射；$\\Phi^\\prime$ 为 Jacobian，$T$ 表示转置，$J$ 为辛2形式的矩阵，$\\Phi^{\\prime -T}$ 表示 Jacobian 的逆转置。矩阵的逆与映射的全局逆须区分。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.symplecticInverse",
  "reusable_proofs": [
    "MolecularDynamics.IsTextbookSymplecticEquiv.symm"
  ],
  "extra_assumptions": [
    "[EXTRA]e为确实全局双射且e和e⁻¹可微的辛微分同胚；原文前句从det非零推出全球逆无效，另项字面保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT11_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:14:51.636254",
      "before_sha256": "207a59b5bddd92a97d216c88e39a6eb74230278422ebb49094fede6c71b7ab2b",
      "after_sha256": "75a53f3058cbf0151208b0110dd2e5a64784e75a416ea0c2be431ef9aa4c22de",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT11/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticInverse {Nc : ℕ}
    {e : Equiv.Perm (SymplecticCoordinates Nc)} (he : IsTextbookSymplecticEquiv e) :
    IsTextbookSymplecticEquiv e.symm := by
  apply MolecularDynamics.IsTextbookSymplecticEquiv.symm <;> assumption
```
### 实际依赖 MolecularDynamics.IsTextbookSymplectic
```lean
def IsTextbookSymplectic {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) : Prop :=
  Aᵀ * textbookJ Nc * A = textbookJ Nc
```
### 实际依赖 MolecularDynamics.IsTextbookSymplecticEquiv
```lean
def IsTextbookSymplecticEquiv {Nc : ℕ} (e : Equiv.Perm (SymplecticCoordinates Nc)) : Prop :=
  IsTextbookSymplecticMap (e : SymplecticCoordinates Nc → SymplecticCoordinates Nc) ∧
    ContDiff ℝ 1 (e.symm : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
```
### 实际依赖 MolecularDynamics.IsTextbookSymplecticMap
```lean
def IsTextbookSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```
