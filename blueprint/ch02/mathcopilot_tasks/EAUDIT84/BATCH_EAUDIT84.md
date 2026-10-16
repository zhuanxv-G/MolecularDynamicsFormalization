# EAUDIT84：第2章§2.3.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.3.4-MatrixCancellation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.4",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "Hence\n\\[\\frac{\\mathrm d}{\\mathrm dt}W^TJW=W^TJ\\dot W+\\dot W^TJW=0.\\]",
  "proof_latex": "Computing\n\\[W^TJ\\dot W=W^TJ^2SW=-W^TSW,\\]\nwhereas\n\\[\\dot W^TJW=W^TS^TJ^TJW=W^TSW,\\]\nhence\n\\[\\frac{\\mathrm d}{\\mathrm dt}W^TJW=W^TJ\\dot W+\\dot W^TJW=0.\\]",
  "proof_note": "两个中间矩阵等式属于原文证明计算，逐字保留于proof_latex；实际时间乘积导数及常值由FormConstant承担。",
  "proof_discussion_latex": null,
  "context_notation": [
    "W′=JSW由前项背景；本条矩阵恒等式两个乘积项之和为0，实际乘积求导见FormConstant。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.matrixCancellation",
  "reusable_proofs": [
    "MolecularDynamics.hamiltonian_variational_matrix_cancellation"
  ],
  "extra_assumptions": [
    "S对称；任意矩阵W。",
    "[EXTRA] 保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:12:48.900009",
      "before_sha256": "8cbee23d0a77e621b06fa7d21c29169c14b1fab5e43558723f20e230009b0598",
      "after_sha256": "ecf08d7e93193f9463159a98e6265b99e1dfef45ec2555e5f98250e3bdf90d0a",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem matrixCancellation {Nc : ℕ}
    (S W : SymplecticCoordinateMatrix Nc) (hS : S.IsSymm) :
    (textbookJ Nc * S * W)ᵀ * textbookJ Nc * W +
      Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) = 0 := by
  apply MolecularDynamics.hamiltonian_variational_matrix_cancellation <;> assumption

theorem matrixCancellation_time {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (I : Set ℝ) (t : ℝ)
    (_hS : (S t).IsSymm)
    (_hW : HasDerivWithinAt W (textbookJ Nc * S t * W t) I t) :
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s)
      ((textbookJ Nc * S t * W t)ᵀ * textbookJ Nc * W t +
        (W t)ᵀ * textbookJ Nc * (textbookJ Nc * S t * W t)) I t ∧
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s) 0 I t := by
  sorry
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.4-HamiltonSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.4",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "hence\n\\[W^TJW\\equiv W(0)^TJW(0)=J.\\]\nThis proves that the flow map of a Hamiltonian system is a symplectic map.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文W移动取值点疑点另项记录；本最终结论以实际固定时刻流映射的Jacobian表达，不假设其变分方程。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonSymplectic",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]实际解族联合C²；H C²、Φ0=id、τ>0及真实Hamilton ODE。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:12:48.900009",
      "before_sha256": "91e63a1cd1482dda0bd203d7e4a3c2ea74ae6f357ab73d09d61605b49d87b4dd",
      "after_sha256": "177a2fc91707899e1d0f0dbeb3da673a4219d5d49b755828befbf18b694cccde",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH17_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonSymplectic {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t, z)) := by
  apply MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 <;> assumption
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
