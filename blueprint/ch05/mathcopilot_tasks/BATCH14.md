# BATCH14 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.3.2-NormalInverseTaylor
```json
{
  "source_id": "MD-5.3.2-NormalInverseTaylor",
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
  "lean_decl": "MD.Ch05.normalInverseTaylor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际C²和非零梯度，ξ由真实局部能量方程得到；保留反向ξ及以ΔE计的正向余项两个结论，不只证明O(ξ²)。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem normalInverseTaylor : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0,∃ δ > 0,
  ∀ e : ℝ,|e| < δ → ∃ ξ : ℝ,
    H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)=H z+e ∧
    |ξ-e/‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*e^2 ∧
    |H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)-H z-‖MolecularDynamics.Chapter05Review.grad H z‖*ξ| ≤ C*e^2
```

### MD-5.3.2-PatchShellVolume
```json
{
  "source_id": "MD-5.3.2-PatchShellVolume",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "192–193",
  "pdf_page": "213–214",
  "statement_latex": "The volume of this thickened shell is clearly $\\Delta V=\\int_M\\xi d\\sigma$, but since $\\Delta E=H(z+n\\xi)-H(z)=\\nabla H\\cdot n\\xi+O(\\Delta E^2)$, and $n=\\nabla H/\\|\\nabla H\\|$, we have $\\xi=\\Delta E/\\|\\nabla H\\|+O(\\Delta E^2)$, and $\\Delta V=\\int_M\\frac{\\Delta E}{\\|\\nabla H\\|}d\\sigma+O(\\Delta E^2)$. Taking the ratio of $\\Delta V$ to $\\Delta E$ we find $\\Delta V/\\Delta E=\\int_M\\|\\nabla H\\|^{-1}d\\sigma+O(\\Delta E)$. The limit of this as $\\Delta E\\to0$ defines a quantity $\\mu(M)=\\int_M\\|\\nabla H\\|^{-1}d\\sigma$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.patchShellVolume",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际紧可测正则曲面片M及薄法线管；原“clearly”体积式实际还需法线管Jacobian=1+O(ξ)，不是一般曲面的精确体积等式；最终O(ΔE)误差保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem patchShellVolume : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (M : Set (MolecularDynamics.Chapter05Review.E n)),
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  IsCompact M → MeasurableSet M → M ⊆ MolecularDynamics.Chapter05Review.energySurface H c →
  ∃ C > 0,∃ δ > 0,∀ e ∈ Ioo 0 δ,
    |(volume {x | ∃ z ∈ M,∃ s ∈ Ico (0 : ℝ) δ,
        x=z+s • MolecularDynamics.Chapter05Review.normalField H z ∧ H x-H z ≤ e}).toReal/e-
        ((MolecularDynamics.Chapter05Review.microRaw H c) M).toReal| ≤ C*e
```

### MD-5.3.2-WholeShellVolumeLimit
```json
{
  "source_id": "MD-5.3.2-WholeShellVolumeLimit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "192–193",
  "pdf_page": "213–214",
  "statement_latex": "$\\Delta V/\\Delta E=\\int_M\\|\\nabla H\\|^{-1}d\\sigma+O(\\Delta E)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.shellVolumeLimit",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]整个正则紧能量面的壳层极限特例，原任意紧曲面片及O(ΔE)结论另条保留，不用特例替换原全结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem shellVolumeLimit :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  (∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧ ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
  Tendsto (fun ε => (volume {z | c ≤ H z ∧ H z ≤ c+ε}).toReal/ε)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microPartition H c))
```

### MD-5.3.2-MicroRawInvariant
```json
{
  "source_id": "MD-5.3.2-MicroRawInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "193",
  "pdf_page": "214",
  "statement_latex": "As both volume and energy are invariant under the Hamiltonian flow, $\\mu(M)$ must be invariant under the flow, thus $\\mu(\\mathcal F_t(M))=\\mu(M)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.microRawInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原正文调用的实际全流、体积与能量保持先验明确写出；需要推出的是曲面加权raw测度保持，未把该结论作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem microRawInvariant : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (MolecularDynamics.Chapter05Review.microRaw H c) (MolecularDynamics.Chapter05Review.microRaw H c) ∧
    ∀ M,MeasurableSet M → (MolecularDynamics.Chapter05Review.microRaw H c) (Φ t '' M)=(MolecularDynamics.Chapter05Review.microRaw H c) M
```

### MD-5.3.2-MicroInvariant
```json
{
  "source_id": "MD-5.3.2-MicroInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "193",
  "pdf_page": "214",
  "statement_latex": "$\\mu(\\mathcal F_t(M))=\\mu(M)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.microInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]归一化measure版本另列；原始未归一化µ的不变及集合像等式由上一完整条目保留，不能只凭归一化定义编译称全部已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem microInvariant :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (MolecularDynamics.Chapter05Review.microMeasure H c) (MolecularDynamics.Chapter05Review.microMeasure H c)
```

### MD-5.3.2-MicroPartition
```json
{
  "source_id": "MD-5.3.2-MicroPartition",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "193",
  "pdf_page": "214",
  "statement_latex": "The invariant measure of the whole level set $\\Sigma_E$ is defined as the microcanonical partition function $Z_E=\\mu(\\Sigma_E)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "raw测度本身受限于ΣE，univ总质量对应ΣE；ENNReal转实只有有限总质量时适用物理Z_E，概率归一化条件后续明确。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.microPartition",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def microPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := ((MolecularDynamics.Chapter05Review.microRaw H c) univ).toReal
```

### MD-5.3.2-ShellPointValuePrinted
```json
{
  "source_id": "MD-5.3.2-ShellPointValuePrinted",
  "kind": "notation",
  "label": null,
  "section": "5.3.2",
  "printed_page": "191",
  "pdf_page": "212",
  "statement_latex": "The proof that (5.8) can be taken and that\n\\[\\lim_{\\varepsilon\\to0}Z_\\varepsilon^{-1}\\int_D\\phi(q,p)\\rho_\\varepsilon d\\omega=\\rho_0(q,p)=Z_{H=E}^{-1}\\int_D\\phi(q,p)\\delta[H(q,p)-E]d\\omega\\]\nmay be found in the PhD thesis of Hartmann [171, Appendix D].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.shellWeakPairing",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Lean仅提供良类型的测试函数配对记号，不把配对记号的编译当原印刷等式的证明；完整正确弱极限另条，重复Z版本也保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def shellWeakPairing {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.microAverage H c φ
```

### MD-5.3.2-HarmonicEnergy
```json
{
  "source_id": "MD-5.3.2-HarmonicEnergy",
  "kind": "definition",
  "label": "Example 5.1",
  "section": "5.3.2",
  "printed_page": "193",
  "pdf_page": "214",
  "statement_latex": "Example 5.1 Consider the harmonic oscillator $H(q,p)=p^2/2+\\Omega^2q^2/2$. The energy surface $H=E>0$ is an ellipse.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.harmonicEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def harmonicEnergy (Ω : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) := (z 1)^2/2+Ω^2*(z 0)^2/2
```

