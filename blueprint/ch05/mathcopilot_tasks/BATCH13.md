# BATCH13 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.3.2-EnergySurface
```json
{
  "source_id": "MD-5.3.2-EnergySurface",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "191",
  "pdf_page": "212",
  "statement_latex": "We assume the level sets $\\Sigma_E=\\{(q,p)\\mid H(q,p)=E\\}$ to be bounded.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际能量等值集合；有界/正则等使用资格单列，不从定义自动推出。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.energySurface",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```

### MD-5.3.2-SurfaceMeasure
```json
{
  "source_id": "MD-5.3.2-SurfaceMeasure",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "191",
  "pdf_page": "212",
  "statement_latex": "where $d\\sigma$ is the “area element” of the energy surface. (The term “area” in this context might be replaced by “hyperarea” or “volume” since we are in many dimensions.)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.surfaceMeasure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]采用实际规范化Hausdorff超面积受限于等值集合；其与光滑曲面的Gram图公式识别另条且未证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```

### MD-5.3.2-MicroRaw
```json
{
  "source_id": "MD-5.3.2-MicroRaw",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "191",
  "pdf_page": "212",
  "statement_latex": "define the invariant measure of a set $M\\subset\\Sigma_E$ by\n\\[\\mu(M)=\\int_M\\frac1{\\|\\nabla H\\|}d\\sigma.\\]\nThus the invariant measure of interest to us is a rescaling of the indicated metric by the factor $1/\\|\\nabla H\\|$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实曲面受限测度的withDensity；保留原始未归一化测度，不能未经总质量条件称概率测度。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.microRaw",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```

### MD-5.3.2-ShellWeakPrinted
```json
{
  "source_id": "MD-5.3.2-ShellWeakPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "191",
  "pdf_page": "212",
  "statement_latex": "As we decrease $\\varepsilon$, the density remains invariant under Liouville's equation. The prefactor means that we can think of a sequence of smooth densities taken with successively smaller values of $\\varepsilon$ as approaching the limiting distribution defined in terms of the delta function by\n\\[\\rho_0(q,p)=Z_{H=E}^{-1}\\delta[H(q,p)-E].\\tag{5.7}\\]\nTo make this statement precise, the definition of the limit must be taken here in the weak sense, that is, we need to study the limit\n\\[\\lim_{\\varepsilon\\to0}Z_\\varepsilon^{-1}\\int_D\\phi(q,p)\\rho_\\varepsilon d\\omega,\\tag{5.8}\\]\ntaken in relation to a test function $\\phi\\in\\mathcal T$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.shellWeakPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]此处记录全相空间版本D=ℝ^m，微正则测度定义给出分布配对目标；其他约束需重定义相应曲面。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem shellWeakPrinted :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → ∀ φ : MolecularDynamics.Chapter05Review.testSpace n,
    Tendsto (fun ε => (MolecularDynamics.Chapter05Review.shellPartition H c ε)⁻¹*(∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1))
```

### MD-5.3.2-ShellWeakLimitCorrected
```json
{
  "source_id": "MD-5.3.2-ShellWeakLimitCorrected",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "191",
  "pdf_page": "212",
  "statement_latex": "$\\lim_{\\varepsilon\\to0}Z_\\varepsilon^{-1}\\int_D\\phi(q,p)\\rho_\\varepsilon d\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.shellWeakLimit",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]独立修正版：不再对已归一化ρ_ε重复除Zε；可达非空正则能量、C²、紧带及小ε权可积/分母正，全部明示。采用D=ℝ^m；不覆盖附加其他守恒约束的情形。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem shellWeakLimit :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → (∃ z,H z=c) →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (MolecularDynamics.Chapter05Review.shellWeight H c ε) volume ∧ 0 < MolecularDynamics.Chapter05Review.shellPartition H c ε)) →
  ∀ φ : MolecularDynamics.Chapter05Review.testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1))
```

### MD-5.3.2-SurfaceAreaFormula
```json
{
  "source_id": "MD-5.3.2-SurfaceAreaFormula",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "191",
  "pdf_page": "212",
  "statement_latex": "If we can represent the $m-1$-dimensional set $M$ as the image of an open set $U\\in\\mathbb R^{m-1}$ under a smooth mapping $g:\\mathbb R^{m-1}\\to\\Sigma_E$, then we have\n\\[\\operatorname{Vol}(M)=\\int_U\\sqrt{\\det[(g'(\\theta))^Tg'(\\theta)]}\\,d\\theta_1d\\theta_2\\cdots d\\theta_{m-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.surfaceAreaFormula",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]单射C¹浸入及实际Gram矩阵；书中的图须避免重复覆盖和退化，不能把任意光滑映射当无重数面积参数化。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem surfaceAreaFormula :
  ∀ d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E (d+1)) (U : Set (MolecularDynamics.Chapter05Review.E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((MolecularDynamics.Chapter05Review.hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ))
```

### MD-5.3.2-NormalField
```json
{
  "source_id": "MD-5.3.2-NormalField",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "192",
  "pdf_page": "213",
  "statement_latex": "We suppose $\\|\\nabla H\\|$ to be bounded away from zero on $\\Sigma_E$. At each point of $M$ we let $n=\\nabla H/\\|\\nabla H\\|$ be the unit normal to the energy surface and define a local coordinate $\\xi$ measuring distance along the direction of the unit normal.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际梯度和Euclidean范数；非零梯度下才是单位法线，0处Mathlib总化除法不赋予法线意义。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.normalField",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def normalField {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := ‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹ • MolecularDynamics.Chapter05Review.grad H z
```

### MD-5.3.2-NormalEnergyTaylor
```json
{
  "source_id": "MD-5.3.2-NormalEnergyTaylor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "192",
  "pdf_page": "213",
  "statement_latex": "$\\Delta E=H(z+n\\xi)-H(z)=\\nabla H\\cdot n\\xi+O(\\Delta E^2)$, and $n=\\nabla H/\\|\\nabla H\\|$, we have $\\xi=\\Delta E/\\|\\nabla H\\|+O(\\Delta E^2)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.normalEnergyTaylor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]本条写正向实际C²局部Taylor余项O(ξ²)，原ΔE参数与反向ξ展开另条；非零梯度用于局部逆坐标，未以正向式替代所有结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem normalEnergyTaylor :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0, ∃ δ > 0, ∀ s : ℝ, |s| < δ →
    |H (z+s • MolecularDynamics.Chapter05Review.normalField H z)-H z-s*‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*s^2
```

