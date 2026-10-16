# EAUDIT57：第3章§3.4网站修复复审

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

## 原文JSON
```json
{
  "source_id": "MD-3.4-ArbitraryFiniteTruncation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "116",
  "pdf_page": "138",
  "statement_latex": "If the differential equations are infinitely differentiable, we may take the truncation index $k$ as large as we like, but the constants appearing in the above theorem will depend on the truncation index in a complicated way.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同章原始近恒等辛Hamiltonian方法上下文；无限可微不意味着解析或指数误差；每个固定k有自己的δ,A。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.arbitraryFiniteTruncation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "smoothSymplecticData保持全部Hamiltonian/近恒等辛/compact条件；完整∀k匹配作为结论，没有把它当作前提。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT45_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:39:30.646379",
      "before_sha256": "86583387a72c192eebe4d8e52afd1270e52ef14356e3ff6a7288cc70d7d7de9f",
      "after_sha256": "e4f02d684926af6a854134884f02fade9d0315af67d8e941b4f38f24871cc133",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT45/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem arbitraryFiniteTruncation :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ∞ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G := by
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
### 实际依赖 MolecularDynamics.Chapter03Review.actualFlowNearCompact
```lean
def actualFlowNearCompact {n : ℕ} (f : SymplecticCoordinates n → SymplecticCoordinates n)
    (D B : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ B, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter03Review.finiteMatching
```lean
def finiteMatching {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∃ δ > 0, ∃ A > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
      (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧ ‖G h z-Γ h z h‖ ≤ A*h^(k+1)
```
### 实际依赖 MolecularDynamics.Chapter03Review.localOrder
```lean
def localOrder {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G Φ : ℝ → E → E) (B : Set E) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
    ‖G h z-Φ h z‖ ≤ C*|h|^(r+1)
```
### 实际依赖 MolecularDynamics.Chapter03Review.smoothSymplecticData
```lean
def smoothSymplecticData {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (r : ℕ) : Prop :=
  0 < r ∧ IsOpen D ∧ Convex ℝ D ∧ IsCompact B ∧ Convex ℝ B ∧ B ⊆ D ∧
  ContDiffOn ℝ ⊤ H D ∧
  (∀ z ∈ D, G 0 z=z) ∧
  (∃ η > 0, ContDiffOn ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-η) η ×ˢ D) ∧
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    actualFlowNearCompact (textbookHamiltonianVectorField H) D B Φ η) ∧ localOrder G Φ B r
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
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
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
  "source_id": "MD-3.4-ScalarVerletShadow4",
  "kind": "definition",
  "label": null,
  "section": "3.4",
  "printed_page": "117",
  "pdf_page": "139",
  "statement_latex": "The modified energy for the Verlet method for a single degree of freedom system with energy $H=p^2/2+U(q)$ is\n\\[\\widetilde H_h=H+\\frac{h^2}{24}(2p^2U''-(U')^2)\n+h^4\\left(\\frac1{720}p^4U''''-\\frac1{120}p^2U'U'''-\\frac1{240}(U')^2U''-\\frac1{60}p^2((U'')^2+U'U''')\\right)+O(h^6).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文脚注1；有限式只定义h⁴截断，O(h⁶)系数匹配和实际流余项不从定义证明，关联VerletModifiedMatching。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "O(h⁶)的实际修正匹配另为未完成理论；有限函数与余项分开。"
    }
  ],
  "lean_decl": "MD.Ch03.scalarVerletShadow4",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 有限h⁴多项式保留；补足光滑势/紧集上与真实velocity Verlet及该Hamiltonian实际局部流的O(h⁷)端点匹配，对应Hamiltonian O(h⁶)遗漏；新陈述未证明。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT11_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:10.109001",
      "before_sha256": "a5101cc532d90ef5c944cc85a3abb2ecd4d1336227b4f6eae41db0e689774c27",
      "after_sha256": "4e8c062b7b955ade6f531b8432fba74ae5e52183ee108657b56cc523cd8b5636",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH14_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT45_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:39:30.646379",
      "before_sha256": "4e8c062b7b955ade6f531b8432fba74ae5e52183ee108657b56cc523cd8b5636",
      "after_sha256": "32b90fe1e8497066198760ff87f4426ace8bbb5a0555c957855aea684dc9ba6f",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH14_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT45/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def scalarVerletShadow4 (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    p^4*iteratedDeriv 4 U q/720-p^2*deriv U q*iteratedDeriv 3 U q/120-
    (deriv U q)^2*iteratedDeriv 2 U q/240-p^2*((iteratedDeriv 2 U q)^2+deriv U q*iteratedDeriv 3 U q)/60)

theorem scalarVerletShadow4_matching (U : ℝ → ℝ) (_hU : ContDiff ℝ ∞ U)
    (B : Set (ℝ × ℝ)) (_hB : IsCompact B) :
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → (ℝ × ℝ) → ℝ → (ℝ × ℝ),
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, Γ h z 0=z ∧
        solution (fun x : ℝ × ℝ ↦
          (deriv (fun p ↦ scalarVerletShadow4 U h (x.1,p)) x.2,
           -deriv (fun q ↦ scalarVerletShadow4 U h (q,x.2)) x.1)) (Γ h z) 0 h ∧
        ‖(let P := z.2-(h/2)*deriv U z.1
           let Q := z.1+h*P
           (Q,P-(h/2)*deriv U Q))-Γ h z h‖ ≤ C*h^7 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch03.scalarVerletShadow4
```lean
def scalarVerletShadow4 (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    p^4*iteratedDeriv 4 U q/720-p^2*deriv U q*iteratedDeriv 3 U q/120-
    (deriv U q)^2*iteratedDeriv 2 U q/240-p^2*((iteratedDeriv 2 U q)^2+deriv U q*iteratedDeriv 3 U q)/60)
```
### 实际依赖 MolecularDynamics.Chapter02Review.solution
```lean
def solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (γ : ℝ → E) (a b : ℝ) : Prop :=
  ∀ t ∈ Icc a b, HasDerivWithinAt γ (f (γ t)) (Icc a b) t
```
