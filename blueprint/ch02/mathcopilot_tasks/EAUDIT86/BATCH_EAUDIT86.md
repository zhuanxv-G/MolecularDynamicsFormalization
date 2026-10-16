# EAUDIT86：第2章§2.3.6网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.3.6-SymplecticIntegrator",
  "kind": "definition",
  "label": null,
  "section": "2.3.6",
  "printed_page": "80",
  "pdf_page": "102",
  "statement_latex": "A symplectic integrator is an approximation of the flow map that conserves the symplectic 2-form.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "G为给定单步方法；精度资格在前节另行定义；每个可用h步映射保辛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_symplecticIntegrator",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 补实际Hamiltonian流、正阶局部一致性及可用正步长域；保辛性质与数值近似资格合取，C²为充分[EXTRA]，未把无关辛映射冒充积分方法。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:15:41.757944",
      "before_sha256": "9f0dacdb07c272752283eb8ef022a48f80287c29c6b17b97f1c8a4599062f970",
      "after_sha256": "ffcfe357e27f21b6dcf16c058b8e90f22f4db27f0e21b7877032d7c188222af1",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bp_symplecticIntegrator {n : ℕ}
    (H : SymplecticCoordinates n → ℝ) (F : Flow ℝ (SymplecticCoordinates n))
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ContDiff ℝ 2 H ∧
  (∀ t z, HasDerivAt (fun s ↦ F s z) (textbookHamiltonianVectorField H (F t z)) t) ∧
  ∃ δ > 0, (∀ h ∈ Ioo 0 δ, bp_IsSymplecticMap (G h)) ∧
    ∃ r : ℝ, 0 < r ∧ ∀ z, ∃ K ≥ 0, ∃ d > 0, d ≤ δ ∧
      ∀ h ∈ Ioo 0 d, ‖G h z - F h z‖ ≤ K * h^(r+1)
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
### 实际依赖 MD.Ch02.bp_symplecticIntegrator
```lean
def bp_symplecticIntegrator {n : ℕ}
    (H : SymplecticCoordinates n → ℝ) (F : Flow ℝ (SymplecticCoordinates n))
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ContDiff ℝ 2 H ∧
  (∀ t z, HasDerivAt (fun s ↦ F s z) (textbookHamiltonianVectorField H (F t z)) t) ∧
  ∃ δ > 0, (∀ h ∈ Ioo 0 δ, bp_IsSymplecticMap (G h)) ∧
    ∃ r : ℝ, 0 < r ∧ ∀ z, ∃ K ≥ 0, ∃ d > 0, d ≤ δ ∧
      ∀ h ∈ Ioo 0 d, ‖G h z - F h z‖ ≤ K * h^(r+1)
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
  "source_id": "MD-2.3.6-SymplecticEulerPreserves",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.6",
  "printed_page": "81",
  "pdf_page": "103",
  "statement_latex": "This implies that\n\\[\\sum_{i=1}^{N_c}dQ_i\\wedge dP_i=\\sum_{i=1}^{N_c}dq_i\\wedge dp_i,\\]\nwhich means that the method is symplectic.",
  "proof_latex": null,
  "proof_note": "原书给出保辛结论的计算性论证；其中 Hessian 双重求和为零明示留作 simple exercise，未逐项展开该消去计算。原论证完整转录在 proof_discussion_latex 中，不补写原书省略的演算。",
  "proof_discussion_latex": "Computing the 2-form,\n\\[dQ_i\\wedge dP_i=dq_i\\wedge dP_i+hm_i^{-1}dP_i\\wedge dP_i;\\]\nbut $du\\wedge du\\equiv0$ for any $u$, hence\n\\[dQ_i\\wedge dP_i=dq_i\\wedge dP_i;\\]\nand (2.21) implies\n\\[dQ_i\\wedge dP_i=dq_i\\wedge dp_i-h\\sum_{j=1}^{N_c}dq_i\\wedge\\frac{\\partial^2U}{\\partial q_j\\partial q_i}dq_j.\\]\nIt is then a simple exercise to show that\n\\[\\sum_{i=1}^{N_c}\\sum_{j=1}^{N_c}dq_i\\wedge\\frac{\\partial^2U}{\\partial q_j\\partial q_i}dq_j=0,\\]\nusing the skew-symmetry of the wedge product and the fact that the Hessian matrix is symmetric.",
  "context_notation": [
    "Q_i、P_i 为式(2.18)–(2.19)完整一步映射输出的分量，q_i、p_i 为输入分量；dQ_i、dP_i 是该映射对初始 q,p 的微分，N_c 为坐标数。",
    "接续 PDF 第102页的机械 Hamiltonian 模型 H=pᵀM^{-1}p/2+U(q)，M 为固定对角质量矩阵，F(q)=−∇_qU(q)，本条使用 Hessian 对称性与楔积反对称性。",
    "全局 C² 正则性是 Lean 为实际梯度和 Hessian 添加的充分条件，原文此段未逐字列出 C² 假设；标准矩阵逆 M^{-1} 的教材参数域为可逆质量矩阵。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.symplecticEulerPreserves",
  "reusable_proofs": [
    "MolecularDynamics.textbookSymplecticEuler_isSymplectic"
  ],
  "extra_assumptions": [
    "U C²，固定对角质量；真实完整步映射。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:15:41.757944",
      "before_sha256": "3e676c5683cb7b44ab0798f7b32a3e425b18943a4d79d7309fea91648a02d838",
      "after_sha256": "8d9accafa9cca4ff851ec7a8e5bd5945e3f3865e8a08ee7ddc68cbb86fccd649",
      "changed_fields": [
        "proof_note",
        "proof_discussion_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH19_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticEulerPreserves {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticMap (textbookSymplecticEuler m U h) := by
  apply MolecularDynamics.textbookSymplecticEuler_isSymplectic <;> assumption
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
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```
### 实际依赖 MolecularDynamics.textbookPositionDrift
```lean
noncomputable def textbookPositionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
```
### 实际依赖 MolecularDynamics.textbookPositionProjection
```lean
noncomputable def textbookPositionProjection (Nc : ℕ) :
    SymplecticCoordinates Nc →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i => ContinuousLinearMap.proj (Sum.inl i)
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookSymplecticEuler
```lean
noncomputable def textbookSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h
```
