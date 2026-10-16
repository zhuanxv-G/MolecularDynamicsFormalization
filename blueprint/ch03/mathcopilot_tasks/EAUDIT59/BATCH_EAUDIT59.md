# EAUDIT59：第3章§3.6网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.6-HamiltonianFlowStructures",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6",
  "printed_page": "127–128",
  "pdf_page": "149–150",
  "statement_latex": "The flow of a Hamiltonian system of the form $H=p^TM^{-1}p/2+U(q)$ will preserve all of the following:\n1. The symplectic two-form $\\mathrm dq\\wedge\\mathrm dp$.\n2. The Hamiltonian (i.e., the energy) $H$.\n3. The volume in phase space (as the vector field is divergence free).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原书H=p^T M^{-1}p/2+U(q)，q和p分别为配置与动量，M为质量矩阵，U为势能；PDF150页完整列表共四项。本条按批次约定只摘录第1–3项，第4项为time-reversal symmetry。",
    "当前Lean签名采用任意H在开放域D上的C²正则性及localFlowC1条件；它陈述变分方程、辛性、Jacobian行列式为1及可测集合体积守恒，尚未陈述能量守恒。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianFlowStructures",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Hamiltonian在开放域C²；真实localFlowC1的初值、ODE与局部定义域资格，未假设显式反步。",
    "[EXTRA] 补原文Hamiltonian能量沿流守恒，保留变分/辛/体积全部结论；localFlowC1实际资格无显式反步，撤销旧EXTRA对此的过度描述，时间反演由3.6.1处理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:24:41.776948",
      "before_sha256": "be4c01973d74b1024513aa9dc954a553d1bd9ca6ca779efa749b3e8714ef8388",
      "after_sha256": "00bc96652f524c2013fada812e77e49f991b5aabc8da2242b6164c6182011dca",
      "changed_fields": [
        "context_notation",
        "extra_assumptions"
      ],
      "annotation_corrections": {
        "extra_assumptions": {
          "before": [
            "原场在开放域C¹，真实局部流、反步与局部定义域资格显式。"
          ],
          "after": [
            "Hamiltonian在开放域C²；真实localFlowC1的初值、ODE与局部定义域资格，未假设显式反步。",
            "[EXTRA] 补原文Hamiltonian能量沿流守恒，保留变分/辛/体积全部结论；localFlowC1实际资格无显式反步，撤销旧EXTRA对此的过度描述，时间反演由3.6.1处理。"
          ]
        }
      },
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonianFlowStructures :
  ∀ n (H : SymplecticCoordinates n → ℝ) D Ω
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    0 < τ → ContDiffOn ℝ 2 H D → localFlowC1 (textbookHamiltonianVectorField H) D Ω Φ τ →
    (∀ t ∈ Ioo 0 τ, ∀ z ∈ Ω,
      HasDerivAt (fun s => textbookJacobian (fun y => Φ (s,y)) z)
        (textbookJ n*textbookHamiltonianHessian H (Φ (t,z))*textbookJacobian (fun y => Φ (t,y)) z) t) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, IsTextbookSymplectic (textbookJacobian (fun y => Φ (t,y)) z)) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, (textbookJacobian (fun y => Φ (t,y)) z).det = 1) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, H (Φ (t,z))=H z) ∧
    (∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → S ⊆ Ω →
      volume ((fun z => Φ (t,z)) '' S) = volume S) := by
  sorry
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
### 实际依赖 MolecularDynamics.Chapter02Review.localFlowC1
```lean
def localFlowC1 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (D Ω : Set E) (Φ : ℝ × E → E) (τ : ℝ) : Prop :=
  IsOpen D ∧ IsOpen Ω ∧ Ω ⊆ D ∧ ContDiffOn ℝ 1 f D ∧
    ContDiffOn ℝ 1 Φ (Icc 0 τ ×ˢ Ω) ∧
    (∀ z ∈ Ω, Φ (0,z) = z) ∧
    ∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, Φ (t,z) ∈ D ∧
      HasDerivWithinAt (fun s => Φ (s,z)) (f (Φ (t,z))) (Icc 0 τ) t
```
### 实际依赖 MolecularDynamics.textbookHamiltonianHessian
```lean
noncomputable def textbookHamiltonianHessian {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc := fun i j =>
  fderiv ℝ (fderiv ℝ H) z (Pi.single i 1) (Pi.single j 1)
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

## 原文JSON
```json
{
  "source_id": "MD-3.6-VolumeNotSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6",
  "printed_page": "128",
  "pdf_page": "150",
  "statement_latex": "The phase volume conservation can be seen as a consequence of the symplectic property, but it is a weaker condition. It is possible to construct methods that preserve volume but which are not symplectic, and we can build methods that exactly conserve the energy (as we shall show below).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文将相空间体积守恒称为辛性的后果及更弱条件，并断言存在保体积但不辛的方法、存在精确守恒能量的方法；能量方法在此处写作as we shall show below。",
    "当前Lean选用SymplecticCoordinates 2，即四维实相空间，G为C¹映射；它只显式要求各点Jacobian行列式为1及G不辛，未显式陈述全局集合体积守恒，也未覆盖该段其他结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.volumeNotSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 补真实可测集合体积保存及单射，保留det=1和非辛见证；其余原句明确跨条映射HamiltonianFlowStructures及ProjectionEnergy，不静默删原文。"
  ],
  "statement_scope": "辛C¹全局单射映射的真实体积保持及保体积非辛见证；精确能量方法构造由MD-3.5-ProjectionEnergy承担，Hamiltonian流实例由MD-3.6-HamiltonianFlowStructures承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:24:41.776948",
      "before_sha256": "7297168c3c98dde9259b1fca9f4895c33759c60292ed0864e60282fbe2197bb8",
      "after_sha256": "552ec5b7f8fd60d521e587debf38c9bed314235103ec5199215c818306c7a084",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem volumeNotSymplectic :
  ∃ G : SymplecticCoordinates 2 → SymplecticCoordinates 2,
    ContDiff ℝ 1 G ∧ Function.Injective G ∧
    (∀ S, MeasurableSet S → volume (G '' S)=volume S) ∧ (∀ z, (textbookJacobian G z).det=1) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry

theorem volumeNotSymplectic_symplectic_volume (n : ℕ)
    (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (_hG : IsTextbookSymplecticMap G) (_hinj : Function.Injective G) :
    ∀ S, MeasurableSet S → volume (G '' S)=volume S := by
  sorry
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
