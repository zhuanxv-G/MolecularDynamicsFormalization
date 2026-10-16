# EAUDIT83：第2章§2.3.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.3.3-SymplecticMap",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "76",
  "pdf_page": "98",
  "statement_latex": "Let $m=2N_c$. A symplectic map $\\Phi:\\mathbb R^m\\to\\mathbb R^m$ is one that preserves the symplectic differential 2-form. The simplest way to write this is as the following algebraic condition on the Jacobian matrix of $\\Phi$:\n\\[\\Phi'^TJ\\Phi'=J.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "m=2Nc，Jacobian是真实Fréchet导数矩阵；J=[[0,I],[-I,0]]，p.53/PDF75；资格Differentiable。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_IsSymplecticMap",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:11:56.115019",
      "before_sha256": "b0f30a6e3771f7a3a757fb150590e48bce00b0e8e7a47fae90deb2d1419fd943",
      "after_sha256": "05f2d56b6271ea8cbc57cbc5ab46fd8cdee5db893d3c38a27bce6a671b8cdbf3",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT09/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bp_IsSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  Differentiable ℝ Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```
### 实际依赖 MolecularDynamics.IsTextbookSymplectic
```lean
def IsTextbookSymplectic {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) : Prop :=
  Aᵀ * textbookJ Nc * A = textbookJ Nc
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
### 实际依赖 MD.Ch02.bp_IsSymplecticMap
```lean
def bp_IsSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  Differentiable ℝ Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
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
  "source_id": "MD-2.3.3-OneForm",
  "kind": "definition",
  "label": null,
  "section": "2.3.3",
  "printed_page": "76",
  "pdf_page": "98",
  "statement_latex": "A 1-form $\\alpha$ defined on $\\mathbb R^m$ is a family of linear mappings from $\\mathbb R^m$ to $\\mathbb R$, defined for each point of $\\mathbb R^m$. Let $\\boldsymbol a:\\mathbb R^m\\to\\mathbb R^m$, then we may define a one-form associated to this vector by $\\alpha(\\boldsymbol x)(\\boldsymbol\\xi)=\\boldsymbol a(\\boldsymbol x)^T\\boldsymbol\\xi$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "有限维线性泛函自动连续；a(x)对应线性泛函的坐标表示。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.oneFormFamily",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:11:56.115019",
      "before_sha256": "b341c76588680d376c3395aaa0403faec99df79f5cb301d805a4b28a574347f0",
      "after_sha256": "f4c58a473adf3dd0bf7f10675f44c9eb1bf21b0e6326e4a6e8f12319c21aedc9",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT09/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def oneFormFamily (n : ℕ) := Q n → Q n →L[ℝ] ℝ

def oneFormOfCoefficients {n : ℕ} (a : Q n → Q n) (z : Q n) : Q n →L[ℝ] ℝ :=
  ∑ i : Fin n, (a z i) • ContinuousLinearMap.proj i

theorem oneFormOfCoefficients_apply {n : ℕ} (a : Q n → Q n) (z ξ : Q n) :
    oneFormOfCoefficients a z ξ = ∑ i : Fin n, a z i * ξ i := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch02.oneFormFamily
```lean
def oneFormFamily (n : ℕ) := Q n → Q n →L[ℝ] ℝ
```
### 实际依赖 MD.Ch02.oneFormOfCoefficients
```lean
def oneFormOfCoefficients {n : ℕ} (a : Q n → Q n) (z : Q n) : Q n →L[ℝ] ℝ :=
  ∑ i : Fin n, (a z i) • ContinuousLinearMap.proj i
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.3-FormSumWedges",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.3",
  "printed_page": "77",
  "pdf_page": "99",
  "statement_latex": "The wedge product of the coordinate differentials $dq_i,dp_i$ may be written\n\\[dq_i\\wedge dp_i(\\boldsymbol\\xi,\\boldsymbol\\eta)=\\xi_i\\eta_{i+N_c}-\\xi_{i+N_c}\\eta_i=\\boldsymbol\\xi^TJ^{(i)}\\boldsymbol\\eta.\\]\nSumming these terms results in the symplectic 2-form, denoted $\\psi_S$:\n\\[\\psi_S=\\sum_{i=1}^{N_c}dq_i\\wedge dp_i(\\boldsymbol\\xi,\\boldsymbol\\eta)=\\boldsymbol\\xi^T\\left(\\sum_{i=1}^{N_c}J^{(i)}\\right)\\boldsymbol\\eta=\\boldsymbol\\xi^TJ\\boldsymbol\\eta.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "J^(i)单项坐标矩阵公式来自dq/dp真实定义，和式为完整最终结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.formSumWedges",
  "reusable_proofs": [
    "MolecularDynamics.textbookSymplecticForm_eq_sum_wedges"
  ],
  "extra_assumptions": [
    "[EXTRA] 保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:11:56.115019",
      "before_sha256": "dc73e5163fd381ef570ea1c73d78eb0878f3f3647bfcc44e4e797e67f097829d",
      "after_sha256": "e4cc1111e327250576175e055461af5d6d894c88c4be88ecd221ba0cd6b79ea3",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT09/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem formSumWedges (Nc : ℕ) :
    textbookSymplecticForm Nc =
      ∑ i : Fin Nc, textbookWedgeOneForms (textbookDq i) (textbookDp i) := by
  apply MolecularDynamics.textbookSymplecticForm_eq_sum_wedges <;> assumption

def symplecticComponentMatrix {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinateMatrix Nc :=
  fun a b ↦ if a = Sum.inl i ∧ b = Sum.inr i then 1
    else if a = Sum.inr i ∧ b = Sum.inl i then -1 else 0

theorem formSumWedges_components (Nc : ℕ) :
    (∀ (i : Fin Nc) (u v : SymplecticCoordinates Nc),
      textbookWedgeOneForms (textbookDq i) (textbookDp i) u v =
        ∑ a, u a * ((symplecticComponentMatrix i) *ᵥ v) a) ∧
    (∑ i : Fin Nc, symplecticComponentMatrix i) = textbookJ Nc := by
  sorry
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
### 实际依赖 MD.Ch02.symplecticComponentMatrix
```lean
def symplecticComponentMatrix {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinateMatrix Nc :=
  fun a b ↦ if a = Sum.inl i ∧ b = Sum.inr i then 1
    else if a = Sum.inr i ∧ b = Sum.inl i then -1 else 0
```
### 实际依赖 MolecularDynamics.textbookDp
```lean
def textbookDp {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinates Nc →ₗ[ℝ] ℝ where
  toFun u := u (Sum.inr i)
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

@[simp] theorem textbookDq_apply {Nc : ℕ} (i : Fin Nc) (u : SymplecticCoordinates Nc) :
    textbookDq i u = u (Sum.inl i) := rfl

@[simp] theorem textbookDp_apply {Nc : ℕ} (i : Fin Nc) (u : SymplecticCoordinates Nc) :
    textbookDp i u = u (Sum.inr i) := rfl
```
### 实际依赖 MolecularDynamics.textbookDq
```lean
def textbookDq {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinates Nc →ₗ[ℝ] ℝ where
  toFun u := u (Sum.inl i)
  map_add' _ _ := rfl
  map_smul' _ _ := rfl
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookSymplecticForm
```lean
noncomputable def textbookSymplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```
### 实际依赖 MolecularDynamics.textbookWedgeOneForms
```lean
def textbookWedgeOneForms {Nc : ℕ} (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) α β -
    LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) β α

@[simp] theorem textbookWedgeOneForms_apply {Nc : ℕ}
    (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) (u v : SymplecticCoordinates Nc) :
    textbookWedgeOneForms α β u v = α u * β v - α v * β u := by
  change α u * β v - β u * α v = _
  ring
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.3-SymplecticIffForm",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.3",
  "printed_page": "78",
  "pdf_page": "100",
  "statement_latex": "In the particular case of the symplectic 2-form $\\psi_S$, we have $A=J$, and the following condition for conservation under the mapping $\\Phi$\n\\[\\Phi'^TJ\\Phi'=J.\\tag{2.17}\\]\nA map that conserves the symplectic 2-form, or, in coordinates, satisfies (2.17), is termed a symplectic map.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.symplecticIffForm",
  "reusable_proofs": [
    "MolecularDynamics.isTextbookSymplecticMap_iff_preserves_form"
  ],
  "extra_assumptions": [
    "[EXTRA] 教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:11:56.115019",
      "before_sha256": "5f2578a0730b0619a25f0c24f21ad2587aaa1067082fec118ce27ffd1bdffe2a",
      "after_sha256": "db572fab0a3766c041069e940d8e2acc5db1133995a435b55c2e7a2242ce0df4",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH16_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT09/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticIffForm {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    bp_IsSymplecticMap Φ ↔ Differentiable ℝ Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  sorry

theorem symplecticIffForm_C1 {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    IsTextbookSymplecticMap Φ ↔ ContDiff ℝ 1 Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  apply MolecularDynamics.isTextbookSymplecticMap_iff_preserves_form <;> assumption
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
### 实际依赖 MD.Ch02.bp_IsSymplecticMap
```lean
def bp_IsSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  Differentiable ℝ Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
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
### 实际依赖 MolecularDynamics.textbookSymplecticForm
```lean
noncomputable def textbookSymplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.3-HamiltonDet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.3",
  "printed_page": "78",
  "pdf_page": "100",
  "statement_latex": "If the system is Hamiltonian, the map is symplectic for all $t$, and the determinant will be a continuous function of $t$, so the cases of interest have $\\det(\\mathcal F_t')=+1$. The flow map of a Hamiltonian system is volume preserving.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同时保留真实流Jacobian det=1及所有可测集合体积保存，不遗漏原文最后一句。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonDet",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。",
    "[EXTRA] 补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:11:56.115019",
      "before_sha256": "a241c4a20045140f14e764e85241f6b5009f23618cc8aa3aa36a85c7b2b5b6f9",
      "after_sha256": "2c12d569605fa91890ff81fd3149e3504e24403c0dbd522351b7b0d5eb6b159c",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH16_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT09/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonDet {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (hH : ContDiff ℝ 2 H) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t)
    (hinit : (fun z => Φ (0,z))=id) :
    (∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z ↦ Φ (t,z))) ∧
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t,y)) z).det=1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (SymplecticCoordinates n), MeasurableSet S →
      volume ((fun z => Φ (t,z)) '' S)=volume S) := by
  constructor
  · exact MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 H hH Φ hΦ τ hODE hinit
  · constructor
    · exact MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2 H hH Φ hΦ τ hODE hinit
    · exact MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 H hH Φ hΦ τ hODE hinit
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
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
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
