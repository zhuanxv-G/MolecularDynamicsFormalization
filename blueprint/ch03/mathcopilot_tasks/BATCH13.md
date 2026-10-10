# BATCH13 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.4-TruncatedConservation
```json
{
  "source_id": "MD-3.4-TruncatedConservation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Since $\\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have\n\\[\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))=\\widetilde H_k(\\boldsymbol z_n).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "K=H̃_k代入签名的H；本条对任意真实Hamiltonian曲线成立，不预设守恒结论。"
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
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem truncatedConservation (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0)
```

### MD-3.4-EnergyTelescoping
```json
{
  "source_id": "MD-3.4-EnergyTelescoping",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Now\n\\[\\begin{aligned}\\widetilde H_k(\\boldsymbol z_\\nu)-\\widetilde H_k(\\boldsymbol z_0)&=\\sum_{n=0}^{\\nu-1}\\widetilde H_k(\\boldsymbol z_{n+1})-\\widetilde H_k(\\boldsymbol z_n)\\\\\n&=\\sum_{n=0}^{\\nu-1}\\widetilde H_k(\\boldsymbol z_{n+1})-\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))\\\\\n&=\\sum_{n=0}^{\\nu-1}\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)+\\boldsymbol\\eta_n)-\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "第一行是任意K的真实迭代有限和恒等式；第二、三行由同页独立TruncatedConservation与FiniteMatchingConstruction代入，并非本条额外假设能量守恒。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.energyTelescoping",
  "reusable_proofs": [
    "MolecularDynamics.oneStep_energy_telescoping"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem energyTelescoping {E : Type*} (K : E → ℝ)
    (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    ∑ i ∈ Finset.range n, (K (oneStepIterate G h z₀ (i + 1)) -
      K (oneStepIterate G h z₀ i)) = K (oneStepIterate G h z₀ n) - K z₀
```

### MD-3.4-UniformTruncatedLipschitz
```json
{
  "source_id": "MD-3.4-UniformTruncatedLipschitz",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Hence\n\\[|\\widetilde H_k(\\boldsymbol z_\\nu)-\\widetilde H_k(\\boldsymbol z_0)|\\le L\\sum_{n=0}^{\\nu-1}\\|\\boldsymbol\\eta_n\\|\\le L\\nu h^{k+1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "此行所用实际H̃_k的统一L；原文先对H取L然后沿用到H̃_k，需要补本条严格辅助；整段漂移界见PhysicalEnergyDrift。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.uniformTruncatedLipschitz",
  "reusable_proofs": [
    "MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_lipschitz"
  ],
  "extra_assumptions": [
    "开放D、紧凸B⊆D及H和有限H_j在D C¹；0≤h≤1；L由有限系数导数界推出。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem uniformTruncatedLipschitz
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ∃ L : ℝ, 0 < L ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ u ∈ B, ∀ v ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h v -
        textbookTruncatedHamiltonian H Hj r k h u‖ ≤ L * ‖v - u‖
```

### MD-3.4-TruncationRemainder
```json
{
  "source_id": "MD-3.4-TruncationRemainder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Next observe that\n\\[H=\\widetilde H_k-h^rH_{(r)}-h^{r+1}H_{(r+1)}-\\cdots-h^kH_{(k)}=\\widetilde H_k+O(h^r).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "固定r,k；实际有限式(3.11)，非无穷级数；绝对值即ℝ范数。"
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
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem truncationRemainder
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (B : Set E) (hB : IsCompact B)
    (hHj : ∀ j ∈ Finset.Icc r k, ContinuousOn (Hj j) B) :
    ∃ C : ℝ, 0 < C ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h z - H z‖ ≤ C * h ^ r
```

### MD-3.4-PhysicalEnergyDrift
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
    "开放D、紧凸B⊆D及有限C¹系数；给定真实截断ODE族γ及其留B、γ(h,z,0)=z，未假设γ的能量守恒或误差界。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
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
            γ h (oneStepIterate G h z₀ i) h‖
```

### MD-3.4-PolynomialEnergyRate
```json
{
  "source_id": "MD-3.4-PolynomialEnergyRate",
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
    "只桥接原书证明的“已有实际局部缺陷界后的条件推论”；整体构造/匹配为FiniteMatchingConstruction未完成，不能以此宣称Thm3.1完整已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.polynomialEnergyRate",
  "reusable_proofs": [
    "MolecularDynamics.textbook_energy_drift_rate_of_flow_defect",
    "需另证FiniteMatchingConstruction；本条仅条件化先验推论"
  ],
  "extra_assumptions": [
    "[EXTRA]hdefect是假设明确给出的实际一步O(h^(k+1))端点界，源自原书“By construction”尚未形式化的先验；不是本条能量结论。",
    "D/B及C¹、实际截断ODE留B、r≤k、A,T≥0、0<h≤1、数值轨道留B；长时间条件νhh^(k−r)≤T。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem polynomialEnergyRate
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (hrk : r ≤ k) (D B : Set (SymplecticCoordinates Nc))
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
    (A T : ℝ) (hA : 0 ≤ A) (hT : 0 ≤ T)
    (hdefect : ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z ∈ B, ‖G h z - γ h z h‖ ≤ A * h ^ (k + 1)) :
    ∃ M : ℝ, 0 < M ∧ ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
      (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
      (n : ℝ) * h * h ^ (k - r) ≤ T →
      ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ M * h ^ r
```

### MD-3.4-StepCountPower
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
    "自然数r≤k使k−r没有截断损失；不将此代数辅助冒充完整能量定理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem stepCountPower (r k n : ℕ) (hrk : r ≤ k) (h : ℝ) :
    (n : ℝ) * h ^ (k + 1) = ((n : ℝ) * h * h ^ (k - r)) * h ^ r
```

### MD-3.4-ArbitraryFiniteTruncation
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
    "smoothSymplecticData保持全部Hamiltonian/近恒等辛/compact条件；完整∀k匹配作为结论，没有把它当作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem arbitraryFiniteTruncation :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G
```

