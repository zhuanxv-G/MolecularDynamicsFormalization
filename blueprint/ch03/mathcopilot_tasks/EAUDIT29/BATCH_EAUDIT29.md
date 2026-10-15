# EAUDIT29：第3章§3.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.4-TruncatedHamiltonian",
  "kind": "definition",
  "label": "(3.11)",
  "section": "3.4",
  "printed_page": "114",
  "pdf_page": "136",
  "statement_latex": "Define\n\\[\\bar H_k\\stackrel{\\mathrm{def}}=H+h^rH_r+h^{r+1}H_{r+1}+\\cdots+h^kH_k.\\tag{3.11}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文(3.10)为形式H̃_h=H+h^rH_r+h^{r+1}H_{r+1}+⋯；(3.11)是实际有限函数，不需无限级数收敛；r≤k。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncatedHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.676992",
      "before_sha256": "ac4cc14d0f3a7c31bf0608816c81e86092d62a37f6dd5edd0524a4444420d804",
      "after_sha256": "62b57599139fffe1e32197b160f02d47d03aa2c17c7f429a489867e2e80f7244",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
noncomputable def truncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```
### 实际依赖 MD.Ch03.truncatedHamiltonian
```lean
noncomputable def truncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-TruncatedFlow",
  "kind": "definition",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Denote by $\\mathcal F_h^{(k)}$ the flow map of the truncated Hamiltonian expansion $\\bar H_k$,\n\\[\\mathcal F_h^{(k)}\\stackrel{\\mathrm{def}}=\\exp(h\\mathcal L_{\\bar H_k}).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际γ(0)=z、γ满足J∇H̄_k的ODE，F_h^(k)(z)=γ(h)；本关系不把exp记号当解存在证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncatedFlow",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "61bc37dfdeb03870c8fc7f61ab9fc701efc3f54d9c44fba5ec5f3bb35643bae4",
      "after_sha256": "b360292fa328eec110a161a42f4fa24865bdd6c5b20559284362201a16111c8e",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
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
### 实际依赖 MolecularDynamics.Chapter02Review.solution
```lean
def solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (γ : ℝ → E) (a b : ℝ) : Prop :=
  ∀ t ∈ Icc a b, HasDerivWithinAt γ (f (γ t)) (Icc a b) t
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
### 实际依赖 MolecularDynamics.textbookTruncatedHamiltonian
```lean
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```
### 实际依赖 MD.Ch03.truncatedFlow
```lean
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-TruncatedConservation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Since $\\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have\n\\[\\bar H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))=\\widetilde H_k(\\boldsymbol z_n).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "K=H̃_k代入签名的H；本条对任意真实Hamiltonian曲线成立，不预设守恒结论。",
    "原书(3.11)用bar H_k表示有限截断；PDF137局部与tilde H_k混用，疑为排版/记号疑误，需明确按同一截断函数解释，保留原印记号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncatedConservation",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonian_energy_const_on_Icc"
  ],
  "extra_assumptions": [
    "沿γ对K的可微性与真实ODE在闭区间明示，包含端点；构造γ属于另项。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "910d3c00c0119303a9656df473b9bbdf972e8f6f89527f2a5c62521f793aa8bf",
      "after_sha256": "349a8a6c3b7cf3802975d5e2a398d74bef960103ecf3cdb6becf1d3cb9534613",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem truncatedConservation (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  apply MolecularDynamics.textbookHamiltonian_energy_const_on_Icc <;> assumption
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

## 原文JSON
```json
{
  "source_id": "MD-3.4-EnergyTelescoping",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Now\n\\[\\begin{aligned}\\bar H_k(\\boldsymbol z_\\nu)-\\bar H_k(\\boldsymbol z_0)&=\\sum_{n=0}^{\\nu-1}\\bar H_k(\\boldsymbol z_{n+1})-\\bar H_k(\\boldsymbol z_n)\\\\\n&=\\sum_{n=0}^{\\nu-1}\\bar H_k(\\boldsymbol z_{n+1})-\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))\\\\\n&=\\sum_{n=0}^{\\nu-1}\\bar H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)+\\boldsymbol\\eta_n)-\\bar H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "第一行是任意K的真实迭代有限和恒等式；第二、三行由同页独立TruncatedConservation与FiniteMatchingConstruction代入，并非本条额外假设能量守恒。",
    "原书(3.11)用bar H_k表示有限截断；PDF137局部与tilde H_k混用，疑为排版/记号疑误，需明确按同一截断函数解释，保留原印记号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.energyTelescoping",
  "reusable_proofs": [
    "MolecularDynamics.oneStep_energy_telescoping"
  ],
  "extra_assumptions": [
    "[EXTRA] 保留已证首行望远镜恒等式；补给定守恒截断步F、真实差η=数值步−F的完整三行等式，不以待证能量差为前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "de20b055edb615e0a109296cd43aa689beb65c85269bb2f60b9283eee92db62d",
      "after_sha256": "ea1214c8822564237ccdc8bb6d84befa5db0cdaccaf54fe75f4d60fcaf4f64e0",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem energyTelescoping {E : Type*} (K : E → ℝ)
    (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    ∑ i ∈ Finset.range n, (K (oneStepIterate G h z₀ (i + 1)) -
      K (oneStepIterate G h z₀ i)) = K (oneStepIterate G h z₀ n) - K z₀ := by
  apply MolecularDynamics.oneStep_energy_telescoping <;> assumption

theorem energyTelescoping_complete (K : E → ℝ) (G : ℝ → E → E)
    (F : E → E) (h : ℝ) (z₀ : E) (n : ℕ)
    (_hconserve : ∀ i < n, K (F (oneStepIterate G h z₀ i))=K (oneStepIterate G h z₀ i)) :
    let z := oneStepIterate G h z₀
    let η := fun i ↦ z (i+1)-F (z i)
    K (z n)-K z₀ = ∑ i ∈ Finset.range n, (K (z (i+1))-K (z i)) ∧
    (∑ i ∈ Finset.range n, (K (z (i+1))-K (z i))) =
      ∑ i ∈ Finset.range n, (K (z (i+1))-K (F (z i))) ∧
    (∑ i ∈ Finset.range n, (K (z (i+1))-K (F (z i)))) =
      ∑ i ∈ Finset.range n, (K (F (z i)+η i)-K (F (z i))) := by
  sorry
```
### 实际依赖 MolecularDynamics.oneStepIterate
```lean
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-UniformTruncatedLipschitz",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Hence\n\\[|\\bar H_k(\\boldsymbol z_\\nu)-\\bar H_k(\\boldsymbol z_0)|\\le L\\sum_{n=0}^{\\nu-1}\\|\\boldsymbol\\eta_n\\|\\le L\\nu h^{k+1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "此行所用实际H̃_k的统一L；原文先对H取L然后沿用到H̃_k，需要补本条严格辅助；整段漂移界见PhysicalEnergyDrift。",
    "原书(3.11)用bar H_k表示有限截断；PDF137局部与tilde H_k混用，疑为排版/记号疑误，需明确按同一截断函数解释，保留原印记号。",
    "原书未说明将缺陷常数C吸收到L，严格界应为LAνh^(k+1)，重选L须明确；不静默修改原文。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.uniformTruncatedLipschitz",
  "reusable_proofs": [
    "MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_lipschitz"
  ],
  "extra_assumptions": [
    "开放D、紧凸B⊆D及H和有限H_j在D C¹；0≤h≤1；L由有限系数导数界推出。",
    "[EXTRA] 保留统一截断Lipschitz定理，补原完整能量差≤LΣ‖η‖≤LAνh^(k+1)链；A为原文缺陷常数重命名，F为所给守恒截断一步。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "63854e9ea6b83ac0cb9b96cbacde956d45e2f08d89c8a80700feeec4eac73719",
      "after_sha256": "d28ff4e99d21bee1e44c341cacc438d81dc369254daa45acfa0d683728ee9614",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem uniformTruncatedLipschitz
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ∃ L : ℝ, 0 < L ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ u ∈ B, ∀ v ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h v -
        textbookTruncatedHamiltonian H Hj r k h u‖ ≤ L * ‖v - u‖ := by
  apply MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_lipschitz <;> assumption

theorem uniformTruncatedLipschitz_chain (K : E → ℝ) (G : ℝ → E → E)
    (F : E → E) (h L A : ℝ) (k n : ℕ) (z₀ : E)
    (_hh : 0 ≤ h) (_hL : 0 ≤ L) (_hA : 0 ≤ A)
    (_hconserve : ∀ i < n, K (F (oneStepIterate G h z₀ i))=K (oneStepIterate G h z₀ i))
    (_hlip : ∀ i < n,
      |K (oneStepIterate G h z₀ (i+1))-K (F (oneStepIterate G h z₀ i))| ≤
        L*‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖)
    (_hdefect : ∀ i < n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖ ≤ A*h^(k+1)) :
    |K (oneStepIterate G h z₀ n)-K z₀| ≤
      L*∑ i ∈ Finset.range n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖ ∧
    (L*∑ i ∈ Finset.range n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖) ≤
      L*A*(n:ℝ)*h^(k+1) := by
  sorry
```
### 实际依赖 MolecularDynamics.oneStepIterate
```lean
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _
```
### 实际依赖 MolecularDynamics.textbookTruncatedHamiltonian
```lean
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-TruncationRemainder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Next observe that\n\\[H=\\bar H_k-h^rH_{(r)}-h^{r+1}H_{(r+1)}-\\cdots-h^kH_{(k)}=\\bar H_k+O(h^r).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "固定r,k；实际有限式(3.11)，非无穷级数；绝对值即ℝ范数。",
    "原书(3.11)用bar H_k表示有限截断；PDF137局部与tilde H_k混用，疑为排版/记号疑误，需明确按同一截断函数解释，保留原印记号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncationRemainder",
  "reusable_proofs": [
    "MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_remainder"
  ],
  "extra_assumptions": [
    "各有限系数在紧B连续；0≤h≤1；统一正C由紧性推出，未供应所需余项界。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "7eaf7fad1a97fd4946b4e6c23d6291c90cbd917439269f43fa35be083f89919d",
      "after_sha256": "77a8ad31e894ddfc8294ef150eef0226e49503b43775bbdb3a92a0a90cd2eb97",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem truncationRemainder
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (B : Set E) (hB : IsCompact B)
    (hHj : ∀ j ∈ Finset.Icc r k, ContinuousOn (Hj j) B) :
    ∃ C : ℝ, 0 < C ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h z - H z‖ ≤ C * h ^ r := by
  apply MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_remainder <;> assumption
```
### 实际依赖 MolecularDynamics.textbookTruncatedHamiltonian
```lean
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-PhysicalEnergyDrift",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Therefore\n\\[|H(\\boldsymbol z_\\nu)-H(\\boldsymbol z_0)|\\le L\\nu h^{k+1}+O(h^r),\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页先得H̃_k有限和变化，再用起点和终点各一份H−H̃_k的余项；这条先以实际端点缺陷的和给界，νh^(k+1)替换见下一条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.physicalEnergyDrift",
  "reusable_proofs": [
    "MolecularDynamics.textbook_energy_drift_le_actual_defects"
  ],
  "extra_assumptions": [
    "开放D、紧凸B⊆D及有限C¹系数；给定真实截断ODE族γ及其留B、γ(h,z,0)=z，未假设γ的能量守恒或误差界。",
    "[EXTRA] 保留已证实际缺陷和界，新增实际截断流的统一一步匹配误差资格与完整2Ch^r+LAνh^(k+1)结论；不是以能量结论为假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT11_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:10.109001",
      "before_sha256": "a607ab89a08ac12397dee03d26db6312f5d66679193cb507992e0f788755da9d",
      "after_sha256": "cd73ff97cc932e98e8e2070f34e5e99dc6834ba8ed4fe76771ef3e36684e320a",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT11/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem physicalEnergyDrift
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t) :
    ∃ C : ℝ, 0 < C ∧ ∃ L : ℝ, 0 < L ∧
      ∀ h ∈ Icc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
        (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
        ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ 2 * C * h ^ r +
          L * ∑ i ∈ Finset.range n, ‖G h (oneStepIterate G h z₀ i) -
            γ h (oneStepIterate G h z₀ i) h‖ := by
  apply MolecularDynamics.textbook_energy_drift_le_actual_defects <;> assumption

theorem physicalEnergyDrift_complete
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t)
    (A : ℝ) (_hA : 0 ≤ A)
    (_hdefect : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ‖G h z-γ h z h‖ ≤ A*h^(k+1)) :
    ∃ C : ℝ, 0 < C ∧ ∃ L : ℝ, 0 < L ∧
      ∀ h ∈ Icc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
        (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
        ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ 2 * C * h ^ r +
          L*A*(n:ℝ)*h^(k+1) := by
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
### 实际依赖 MolecularDynamics.oneStepIterate
```lean
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _
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
### 实际依赖 MolecularDynamics.textbookTruncatedHamiltonian
```lean
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-StepCountPower",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "116",
  "pdf_page": "138",
  "statement_latex": "so that, as long as $\\nu\\le C_2h^{-k+r-1}$, we have\n\\[|H(\\boldsymbol z_\\nu)-H(\\boldsymbol z_0)|\\le O(h^r).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "旧CH03-081是该证明用到的代数换写νh^(k+1)=(νhh^(k−r))h^r；原文没有单独展示等式，作为证明辅助单列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.stepCountPower",
  "reusable_proofs": [
    "MolecularDynamics.energy_step_count_power_factor"
  ],
  "extra_assumptions": [
    "自然数r≤k使k−r没有截断损失；不将此代数辅助冒充完整能量定理。",
    "[EXTRA] 本条仅承担步数幂次代数辅助；原句的完整能量率由MD-3.4-PolynomialEnergyRate承担，原文不删并显式跨条映射。"
  ],
  "statement_scope": "仅步数/步长幂次分解代数辅助；本条所引原句能量O(h^r)由MD-3.4-PolynomialEnergyRate承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT11_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:10.109001",
      "before_sha256": "b96d1ed64e1338e6eb8a0dc597b1868f07230b37737e2479ef689bedee1e79ee",
      "after_sha256": "8a15b2b5931dddfaf9170548ba1d83e4e0e27e1755c43fd7bdf71f58bcf619e8",
      "changed_fields": [
        "statement_scope",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT11/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem stepCountPower (r k n : ℕ) (hrk : r ≤ k) (h : ℝ) :
    (n : ℝ) * h ^ (k + 1) = ((n : ℝ) * h * h ^ (k - r)) * h ^ r := by
  apply MolecularDynamics.energy_step_count_power_factor <;> assumption
```
