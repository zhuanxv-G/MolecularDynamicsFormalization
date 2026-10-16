# EAUDIT02：第5章§5.2.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.2.1-DomainL2",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "The set of functions from $\\mathcal D\\subset\\mathbb R^m$ to $\\mathbb R$ which satisfy (5.3) is referred to as the space $L^2(\\mathcal D)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF p.204，式(5.3)：$\\int_{\\mathcal D}\\phi^2(z)\\,d\\omega<\\infty$；原书此处使用 $\\phi$，不是 $\\rho$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Mathlib Lp使用Lebesgue可测函数的AE等价类；书中未写商空间，若不取AE类，所谓范数可能为0而原始函数非零。保留一般D；透明别名复用实际Lp的实例。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:51:26.481234",
      "before_sha256": "5b14d53d3ecc891cdc6c25e192ddadefd31f6c9e9dbb3fadeb974646c89c474d",
      "after_sha256": "db07d8909315a28443eb49c5c8d8134ca979dedfb8226a961d9736a703db2b01",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
@[reducible] def domainL2 (n : ℕ) (D : Set (MolecularDynamics.Chapter05Review.E n)) := Lp ℝ 2 (volume.restrict D)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.1-L2Norm",
  "kind": "definition",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "we define the $L^2(\\mathcal D)$ norm by $\\|\\phi\\|_{L^2(\\mathcal D)}\\stackrel{\\rm def}{=}[\\int_{\\mathcal D}\\phi^2(z)\\,d\\omega]^{1/2}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Lp范数；与原积分公式的等式独立定理，不将定义编译冒称公式已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2Norm",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:51:26.481234",
      "before_sha256": "9d485865bb964f6e09b5aaa29e28e8a47c358f39bb1bf72ce2fe8ac3a0dbfb11",
      "after_sha256": "b423168e85956f512c4c600c57cc292a1e1997a4b7c8dbfe3d64949700b79f3c",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def domainL2Norm {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.domainL2Norm
```lean
def domainL2Norm {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.1-L2NormSquare",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "Thus $\\|\\phi\\|_{L^2(\\mathcal D)}^2=\\langle\\phi,\\phi\\rangle_{L^2(\\mathcal D)}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Lp内积到积分桥接，不假设范数积分公式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2NormSquare",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:51:26.481234",
      "before_sha256": "0bbc6044264c8a525c1e2da29e8b3dc0ff8a05e3c8a567527265969e30fae948",
      "after_sha256": "8feb6bc495d82481ed6f8870f7054ecda42fbac60f3168ed2cf7eab3728c6239",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem domainL2NormSquare : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (g : domainL2 n D),
  domainL2Norm g^2=domainL2Inner g g := by
  intro n D g
  change ‖g‖^2=∫ z in D,g z*g z
  simpa only [MeasureTheory.L2.inner_def,Real.inner_apply] using (real_inner_self_eq_norm_sq g).symm
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.domainL2Inner
```lean
def domainL2Inner {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (f g : domainL2 n D) : ℝ :=
  ∫ z in D,f z*g z
```
### 实际依赖 MD.Ch05.domainL2Norm
```lean
def domainL2Norm {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖
```

## 原文JSON
```json
{
  "source_id": "MD-5.2.1-L2Complete",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.1",
  "printed_page": "183",
  "pdf_page": "204",
  "statement_latex": "This is a real Hilbert space or complete inner product space in which, for any $\\phi,\\psi\\in L^2(\\mathcal D)$, the inner product is defined by $\\langle\\phi,\\psi\\rangle_{L^2(\\mathcal D)}\\stackrel{\\rm def}{=}\\int_{\\mathcal D}\\phi(z)\\psi(z)\\,d\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.domainL2Complete",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完备结论在AE商L²上；原生函数集合的正定性缺AE资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:51:26.481234",
      "before_sha256": "488a8082a07280aaf75f7f09e67ed38a546eb410aea0251bc62a7fb18f2012d3",
      "after_sha256": "1d3f9ac8414ff11433e182bcf7600702337a0b7945bc12589020fcdfb3764ca1",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem domainL2Complete : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v) := by
  intro n D u hu
  exact cauchySeq_tendsto_of_complete hu
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
