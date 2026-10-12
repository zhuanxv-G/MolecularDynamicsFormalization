# BATCH03 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.2.1-DensityOn
```json
{
  "source_id": "MD-5.2.1-DensityOn",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "182",
  "pdf_page": "203",
  "statement_latex": "Let $D\\subset\\mathbb R^m$ be a suitable set comprising the collection of admissible phase space points $z$. A density on $D$ is a function $\\rho:D\\to\\mathbb R$ such that (i) $\\rho(z)\\geq0,z\\in D$, and (ii) $\\int_D\\rho\\,d\\omega<\\infty$, where $d\\omega=dz_1dz_2\\cdots dz_m$ (i.e. $\\int_D\\rho\\,d\\omega$ is the integral of the measurable function $\\rho$ in the Lebesgue sense).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.densityOn",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]域外值不影响受限积分；NullMeasurableSet表达Lebesgue完备化可测域，AEMeasurable表达受限Lebesgue可测函数；非负且可积对应有限非负积分。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def densityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  NullMeasurableSet D volume ∧ AEMeasurable ρ (volume.restrict D) ∧
    (∀ z ∈ D,0 ≤ ρ z) ∧ IntegrableOn ρ D
```

### MD-5.2.1-ProbabilityDensityOn
```json
{
  "source_id": "MD-5.2.1-ProbabilityDensityOn",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "182",
  "pdf_page": "203",
  "statement_latex": "A probability density function (or p.d.f.) on $D$ is a density which is normalized so that $\\int_D\\rho\\,d\\omega=1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留任意Lebesgue可测域D，不用全空间替代。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.probabilityDensityOn",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def probabilityDensityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  densityOn D ρ ∧ (∫ z in D,ρ z)=1
```

### MD-5.2.1-DensityOnNormalization
```json
{
  "source_id": "MD-5.2.1-DensityOnNormalization",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "182",
  "pdf_page": "203",
  "statement_latex": "Any density (with positive total integral) can be normalized by dividing by $\\int_D\\rho\\,d\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际受限Bochner积分及正的归一化分母，不把归一化作假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.densityOnNormalization",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem densityOnNormalization : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityOn D ρ → 0 < (∫ z in D,ρ z) →
    probabilityDensityOn D (fun z => ρ z/(∫ x in D,ρ x))
```

### MD-5.2.1-DensityProbability
```json
{
  "source_id": "MD-5.2.1-DensityProbability",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "182",
  "pdf_page": "203",
  "statement_latex": "For any measurable subset $A$ of $D$, and probability density $\\rho$, we define $\\operatorname{Pr}(A)\\stackrel{\\rm def}{=}\\int_A\\rho\\,d\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "使用条件A⊆D、A可测、probabilityDensityOn D ρ在后续界定理中明确，不给域外概率意义。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.densityProbability",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def densityProbability {n : ℕ} (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) : ℝ :=
  ∫ z in A,ρ z
```

### MD-5.2.1-DensityMeasureOn
```json
{
  "source_id": "MD-5.2.1-DensityMeasureOn",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "182",
  "pdf_page": "203",
  "statement_latex": "For any measurable subset $A$ of $D$, and probability density $\\rho$, we define $\\operatorname{Pr}(A)\\stackrel{\\rm def}{=}\\int_A\\rho\\,d\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.densityMeasureOn",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际受限Lebesgue测度的withDensity实现；概率归一化需要上条完整条件，不限制一般概率测度都必须有密度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def densityMeasureOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (volume.restrict D).withDensity (fun z => ENNReal.ofReal (ρ z))
```

### MD-5.2.1-LebesgueClosure
```json
{
  "source_id": "MD-5.2.1-LebesgueClosure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "182",
  "pdf_page": "203",
  "statement_latex": "The technical requirement is that $D$ be Lebesgue-measurable. Open and closed sets in $\\mathbb R^m$ are Lebesgue-measurable, for example a rectangular box. Sets which are constructed by taking countable unions or intersections of measurable sets are measurable.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留Lebesgue完备化的可测族；Borel生成记号另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.lebesgueClosure",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lebesgueClosure : ∀ n (s : Set (MolecularDynamics.Chapter05Review.E n)) (A : ℕ → Set (MolecularDynamics.Chapter05Review.E n)),
  (IsOpen s → NullMeasurableSet s volume) ∧ (IsClosed s → NullMeasurableSet s volume) ∧
  ((∀ k,NullMeasurableSet (A k) volume) →
    NullMeasurableSet (⋃ k,A k) volume ∧ NullMeasurableSet (⋂ k,A k) volume)
```

### MD-5.2.1-BorelSigma
```json
{
  "source_id": "MD-5.2.1-BorelSigma",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "182",
  "pdf_page": "203",
  "statement_latex": "A suitable family of sets on which Lebesgue measure can be defined is the so-called Borel $\\sigma$-algebra obtained by countable unions, intersections, or relative complements of open balls in $\\mathbb R^m$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Mathlib实际Borel生成σ代数；不混同其完备化的全部Lebesgue可测集合。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.borelSigma",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def borelSigma (n : ℕ) : MeasurableSpace (MolecularDynamics.Chapter05Review.E n) := borel (MolecularDynamics.Chapter05Review.E n)
```

### MD-5.2.1-DensityProbabilityBounds
```json
{
  "source_id": "MD-5.2.1-DensityProbabilityBounds",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "It is automatic that $0\\leq\\operatorname{Pr}(A)\\leq1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.densityProbabilityBounds",
  "reusable_proofs": [],
  "extra_assumptions": [
    "原上下文的A⊆D和Lebesgue可测A明确写入，不把“µ已是概率测度”代替密度归一化所需证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem densityProbabilityBounds : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  probabilityDensityOn D ρ → A ⊆ D → NullMeasurableSet A volume →
    0 ≤ densityProbability ρ A ∧ densityProbability ρ A ≤ 1
```

