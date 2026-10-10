# BATCH16 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.5-ProjectionEnergy
```json
{
  "source_id": "MD-3.5-ProjectionEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "124",
  "pdf_page": "146",
  "statement_latex": "We also must assume that $E-\\overline U\\ge0$, which, for a large system, seems the likely situation, since we may suppose $\\overline K+\\overline U=\\overline E\\approx E$, thus $E-\\overline U\\approx\\overline K\\ge0$. Thus we assume a system with many degrees of freedom so that all the conditions for the method to be well defined are satisfied.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "(3.12)/(3.13)给γ²K+U=E，实际数学资格直接取K>0、U≤E；many degrees of freedom只为经验动机，不能推出此资格。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.projectionEnergy",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.projectionEnergy_proved"
  ],
  "extra_assumptions": [
    "K>0且U≤E显式给出，禁止由自由度数目推算。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem projectionEnergy :
  ∀ E K U : ℝ, 0 < K → U ≤ E → projectionConstraint E K U (projectionFactor E K U)
```

### MD-3.5-KineticZero
```json
{
  "source_id": "MD-3.5-KineticZero",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "124",
  "pdf_page": "146",
  "statement_latex": "If, in the harmonic oscillator, $\\overline p_{n+1}$ happens to vanish, then $\\gamma$ is not defined. We could work around this obstacle by assuming a large number of degrees of freedom, in which case $\\overline K$ is only zero if all the momenta simultaneously vanish and this situation is, in a realistic model of a molecule, extremely unlikely.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "只形式化正质量下K=0 iff p=0；概率extremely unlikely为定性评述，未当普遍数学断言。Lean全除法不代表物理γ定义可用。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.kineticZero",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.kineticZero_proved"
  ],
  "extra_assumptions": [
    "正质量。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem kineticZero :
  ∀ (n : ℕ) (m : Fin n → ℝ) (p : Position n), positiveMass m → (kinetic m p=0 ↔ p=0)
```

### MD-3.5-EnergyProjectionRelation
```json
{
  "source_id": "MD-3.5-EnergyProjectionRelation",
  "kind": "definition",
  "label": null,
  "section": "3.5",
  "printed_page": "124",
  "pdf_page": "146",
  "statement_latex": "There are many alternative projection methods which we could use for this purpose, which might alter both the positions and momenta. Modifying the positions means that we will somehow need to solve the equation\n\\[H(Q,P)=E,\\]\nwhere $Q$ depends on a parameter or parameters (typically a Lagrange multiplier that is used to maintain the constraint).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实能量水平关系；不由定义保证投影解存在、唯一或保几何结构。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.energyProjectionRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def energyProjectionRelation {n : ℕ} (H : Z n → ℝ) (E : ℝ) (z : Z n) : Prop := H z=E
```

### MD-3.5-NoHamiltonianAttractor
```json
{
  "source_id": "MD-3.5-NoHamiltonianAttractor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "126",
  "pdf_page": "148",
  "statement_latex": "In the first phase, the discrete trajectory appears to be filling in the correct region and without any evidence of nonphysical behavior. The performance is very similar to a Verlet method without projection during this period. In the second phase the system begins to move toward a limit cycle, i.e. an attractive periodic orbit. The presence of such limit cycles is impossible in a Hamiltonian system, thus it is evident that an nonphysical artefact has been introduced by the projection method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch03.noHamiltonianAttractor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "明确C²Hamiltonian的全时间真实流、紧零体积周期轨道、开放正有限体积吸引盆；不只给任意一条轨道。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem noHamiltonianAttractor :
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (orbit B : Set (SymplecticCoordinates n)), ContDiff ℝ 2 H →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (textbookHamiltonianVectorField H (Φ t z)) t) →
    IsCompact orbit → orbit.Nonempty → volume orbit=0 → IsOpen B → 0 < volume B → volume B < ⊤ →
    ¬ (∀ z ∈ B, Tendsto (fun t => Metric.infDist (Φ t z) orbit) atTop (𝓝 0))
```

### MD-3.5-LinearContinuousIntegral
```json
{
  "source_id": "MD-3.5-LinearContinuousIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "Generalizing this slightly, we could imagine a system of ODEs of the form\n\\[\\dot{\\boldsymbol z}=f(\\boldsymbol z),\\]\nsuch that, for some vector $\\boldsymbol b$,\n\\[\\boldsymbol b\\cdot f(\\boldsymbol z)\\equiv0,\\]\nthen $I(\\boldsymbol z)=\\boldsymbol b\\cdot\\boldsymbol z$ is a first integral.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整连续轨道first-integral性质；有限Euler及RK保持性质是相邻独立条目。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.linearContinuousIntegral",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实全时间轨道导数资格显式；不宣称任意f有全时间解。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem linearContinuousIntegral :
    ∀ (n : ℕ) (b : Fin n → ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
      (∀ z, ∑ i, b i*f z i = 0) →
      (∀ t, HasDerivAt γ (f (γ t)) t) →
      ∀ t, (∑ i, b i*γ t i) = ∑ i, b i*γ 0 i
```

