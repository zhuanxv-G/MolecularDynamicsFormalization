# BATCH28 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3.8-LangevinMassForward
```json
{
  "source_id": "MD-6.3.8-LangevinMassForward",
  "kind": "definition",
  "label": "(6.42)",
  "section": "6.3.8",
  "printed_page": "244",
  "pdf_page": "265",
  "statement_latex": "In the special case of Langevin dynamics (6.32)–(6.33) for a system with $N_c$ configuration variables, the density is a function of the vectors of positions $q$, momenta $p$, and time, and the formula for the Kolmogorov operator becomes\n\\[\\mathcal L_{\\rm LD}^*\\rho=-\\nabla_q\\cdot(M^{-1}p\\rho)+\\nabla_p\\cdot([\\nabla U(q)+\\gamma p]\\rho)+\\gamma k_BT\\Delta_M\\rho;\\tag{6.42}\\]\nwhere the mass-weighted Laplacian $\\Delta_M$ is defined as\n\\[\\Delta_M\\stackrel{\\rm def}=\\nabla\\cdot(M\\nabla)=\\sum_{i=1}^{N_c}m_i\\frac{\\partial^2}{\\partial p_i^2}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "β⁻¹=kBT，完整全部mi；动量扩散正质量mi，区别于过阻尼配置逆质量mi⁻¹。定义不计真实密度PDE已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinMassForward",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def langevinMassForward {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ β : ℝ)
    (ρ : MolecularDynamics.Chapter06Review.Phase n → ℝ) (x : MolecularDynamics.Chapter06Review.Phase n) : ℝ :=
  ∑ i, (-(m i)⁻¹*x.2 i * fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z : MolecularDynamics.Chapter06Review.Phase n ↦ (textbookConfigurationPartial U i z.1+γ*z.2 i)*ρ z) x (0,Pi.single i 1) +
    γ*β⁻¹*m i*fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single i 1)) x (0,Pi.single i 1))
```

### MD-6.3.8-MomentumMassLaplacian
```json
{
  "source_id": "MD-6.3.8-MomentumMassLaplacian",
  "kind": "definition",
  "label": null,
  "section": "6.3.8",
  "printed_page": "244",
  "pdf_page": "265",
  "statement_latex": "\\[\\Delta_M\\stackrel{\\rm def}=\\nabla\\cdot(M\\nabla)=\\sum_{i=1}^{N_c}m_i\\frac{\\partial^2}{\\partial p_i^2}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际全部动量坐标二阶偏导正质量权重。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.momentumMassLaplacian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def momentumMassLaplacian {n : ℕ} (m : Fin n → ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  ∑ i, m i*fderiv ℝ (fun y ↦ fderiv ℝ ρ y (0,Pi.single i 1)) x (0,Pi.single i 1)
```

### MD-6.3.8-LangevinFPEquation
```json
{
  "source_id": "MD-6.3.8-LangevinFPEquation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.8",
  "printed_page": "244",
  "pdf_page": "265",
  "statement_latex": "the formula for the Kolmogorov operator becomes\n\\[\\mathcal L_{\\rm LD}^*\\rho=-\\nabla_q\\cdot(M^{-1}p\\rho)+\\nabla_p\\cdot([\\nabla U(q)+\\gamma p]\\rho)+\\gamma k_BT\\Delta_M\\rho.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinFPEquation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实任意质量Langevin过程和实际非负平滑密度law及求导尾部资格；不以弱PDE或强PDE作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinFPEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin n → ℝ)) (X : ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ)))
    (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ) (γ β : ℝ)
    (x0 : (Fin n → ℝ) × (Fin n → ℝ)) (ρ : ℝ → ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P → (∀ i, 0 < m i) → 0 < γ → 0 < β →
  MolecularDynamics.Chapter06Review.langevinMassSDE P W X m U γ β⁻¹ x0 → ContDiff ℝ ∞ U →
  ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧ HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ t ∈ Icc lo hi,
    ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*‖x‖)) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=MolecularDynamics.Chapter06Review.langevinMassForward m U γ β (ρ t) x
```

