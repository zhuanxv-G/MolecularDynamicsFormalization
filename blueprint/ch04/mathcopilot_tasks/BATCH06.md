# BATCH06 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.2.2-MollifiedAverage
```json
{
  "source_id": "MD-4.2.2-MollifiedAverage",
  "kind": "definition",
  "label": null,
  "section": "4.2.2",
  "printed_page": "149",
  "pdf_page": "171",
  "statement_latex": "The mapping $\\mathcal A(q)$ is defined by reference to the fast dynamics, e.g. by the weighted average\n\\[\\mathcal A(q)=\\frac1{K+1}\\sum_{i=0}^K\\phi_i\\theta_i(q),\\]\nwhere the $\\theta_i$ are defined recursively by solving the system with Hamiltonian\n\\[H^{\\mathrm{fast}}(q,p)=p^TM^{-1}p/2+U_F(q)\\]\nstarting from initial position $q$ and zero initial momentum $p$, for $K$ timesteps using a small stepsize $\\tau_f$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.mollifiedAverage",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原未指定快积分器，以真实fastVerlet离散位置作为θi的具体实例；K+1项有限加权和，不假定权重任意都有效滤波。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def mollifiedAverage {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (K : ℕ) (w : ℕ → ℝ) (δ : ℝ) (q : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (1/(K+1 : ℝ)) • ∑ i ∈ Finset.range (K+1), w i • ((MolecularDynamics.Chapter04Review.fastVerlet m UF δ)^[i] (q,0)).1
```

### MD-4.2.2-MollifiedPotential
```json
{
  "source_id": "MD-4.2.2-MollifiedPotential",
  "kind": "definition",
  "label": null,
  "section": "4.2.2",
  "printed_page": "149",
  "pdf_page": "171",
  "statement_latex": "Effectively, one replaces $U_S(q)$ wherever it appears within the MTS method by a modified potential function $\\overline U(q)\\stackrel{\\mathrm{def}}=U_S(\\mathcal A(q))$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际US∘A；前条原页加权构造分开，不将def当滤波性能定理。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.mollifiedPotential",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def mollifiedPotential {n : ℕ} (US : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) := US ∘ A
```

### MD-4.2.2-MollifiedStructure
```json
{
  "source_id": "MD-4.2.2-MollifiedStructure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.2",
  "printed_page": "149",
  "pdf_page": "171",
  "statement_latex": "In each of the mollified multiple timestepping methods, since only the potential energy is modified, and by a smooth mapping of positions, the forces derived by differentiating $\\overline U$ are still conservative, and, just as with the MTS method, the scheme remains symplectic.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.mollifiedStructure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量、US/UF/A C²、r>0；实际Fréchet链式法则及RESPA的Jacobian辛性，不假定保结构结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem mollifiedStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → ContDiff ℝ 2 A → 0 < r →
    (∀ q v, (fderiv ℝ (MolecularDynamics.Chapter04Review.mollifiedPotential US A) q) v=(fderiv ℝ US (A q)) ((fderiv ℝ A q) v)) ∧
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m (MolecularDynamics.Chapter04Review.mollifiedPotential US A) UF r h)
```

