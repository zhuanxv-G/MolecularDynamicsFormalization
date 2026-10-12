# BATCH18 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.4.1-UniformMicroErgodic
```json
{
  "source_id": "MD-5.4.1-UniformMicroErgodic",
  "kind": "definition",
  "label": "Definition 5.1",
  "section": "5.4.1",
  "printed_page": "197",
  "pdf_page": "218",
  "statement_latex": "Definition 5.1 A Hamiltonian system is said to be ergodic on an energy surface $\\Sigma_E$ (microcanonically ergodic) if, for almost all trajectories $\\tau$ emanating from initial conditions on $\\Sigma_E$, and for any observable $g$, the following holds $\\bar g=\\operatorname{Av}_{H=E}(g)$, where $\\bar g$ is defined in (5.9). By “almost all” we mean that there could be a low-dimensional subset for which the trajectory averages fail to equal the space averages.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.uniformMicroErgodic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]沿用前文光滑可观测量且明确µ可积，避免给不存在空间平均的函数套等式；AE采用真实µ_E零测资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def uniformMicroErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ⊤ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```

### MD-5.4.1-MicroErgodicStandard
```json
{
  "source_id": "MD-5.4.1-MicroErgodicStandard",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "197",
  "pdf_page": "218",
  "statement_latex": "for almost all trajectories $\\tau$ emanating from initial conditions on $\\Sigma_E$, and for any observable $g$, $\\bar g=\\operatorname{Av}_{H=E}(g)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.microErgodic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]标准每个L¹可观测量各自AE初值版本，和原字面共满测集版本分开；不声称两者已等价。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def microErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
    ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```

### MD-5.4.1-FlowInvariant
```json
{
  "source_id": "MD-5.4.1-FlowInvariant",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "197–198",
  "pdf_page": "218–219",
  "statement_latex": "An invariant set $A$ of the flow is one such that $\\mathcal F_t(A)=A$, for all $t\\ne0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.flowInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原t≠0；真实流的零时刻恒等自动补上t=0，因而用实际全实时间集合像不变性。仅给定的真实流可解释为动力系统不变性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t, Φ t '' A=A
```

### MD-5.4.1-SetErgodic
```json
{
  "source_id": "MD-5.4.1-SetErgodic",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "197–198",
  "pdf_page": "218–219",
  "statement_latex": "Alternatively, we may say that a dynamical system as ergodic if the probability measure of any invariant set $A$ of the flow is either 0 or 1.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.setErgodic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明示集合可测和实际概率测度背景；原“as ergodic”字面保留，不在逐字JSON中默改为“is”。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X) : Prop :=
  ∀ A : Set X, MeasurableSet A → MolecularDynamics.Chapter05Review.flowInvariant Φ A → μ A=0 ∨ μ A=1
```

### MD-5.4.1-InvariantIndicator
```json
{
  "source_id": "MD-5.4.1-InvariantIndicator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198",
  "pdf_page": "219",
  "statement_latex": "Then for any trajectory starting in $A$, we have that the average of $\\phi$ along $\\tau$ vanishes, i.e. $\\bar\\phi=\\lim_{T\\to\\infty}T^{-1}\\int_0^T\\phi(z(t))dt=0$, since $A$ is an invariant set.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.invariantIndicator",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.invariantIndicator_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]原φ是可达空间内A的补集示性函数，实际Measure支撑空间限定时可用ambient Aᶜ示性函数；本条保留沿轨道逐点为零，完整无限时间平均另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem invariantIndicator {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (h : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) (t : ℝ) :
    Aᶜ.indicator (fun _ => (1 : ℝ)) (Φ t z)=0
```

### MD-5.4.1-InvariantIndicatorAverage
```json
{
  "source_id": "MD-5.4.1-InvariantIndicatorAverage",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198",
  "pdf_page": "219",
  "statement_latex": "$\\bar\\phi=\\lim_{T\\to\\infty}T^{-1}\\int_0^T\\phi(z(t))dt=0$, since $A$ is an invariant set.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留真实无限时间平均，不仅逐点补集indicator为0；书中该indicator不一定光滑，需要L¹观测量资格，未用它默证共AE光滑定义的等价性。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.invariantIndicatorAverage",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem invariantIndicatorAverage {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (hA : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) :
  MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) (Aᶜ.indicator (fun _ => (1 : ℝ))) 0
```

### MD-5.4.1-ErgodicTimeEquivalence
```json
{
  "source_id": "MD-5.4.1-ErgodicTimeEquivalence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198",
  "pdf_page": "219",
  "statement_latex": "If we assume the system is ergodic, we must have $\\operatorname{Pr}(\\Sigma_E\\setminus A)=0$, thus $\\operatorname{Pr}(A)=1$. Since, according to the definition, equality of time and space averages is allowed to fail only on a set of probability measure zero, we have that either $\\operatorname{Pr}(A)=0$ or $\\operatorname{Pr}(A)=1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.ergodicTimeAverage",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整全实时间可测流、概率保持、群律及L¹资格；对应标准每观测量AE版本，未将原共满测集量词交换当无条件事实。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem ergodicTimeAverage :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔ ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.average μ g))
```

### MD-5.4.1-NonergodicSet
```json
{
  "source_id": "MD-5.4.1-NonergodicSet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198",
  "pdf_page": "219",
  "statement_latex": "If a system is not ergodic, then there will be an invariant set $A$ whose probability measure is strictly between zero and one. The trajectories emanating from this set are unable to explore the entire energy surface and the corresponding trajectory averages will, at least for some observables, be different than the spatial average of that observable.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际集合遍历性的逻辑等价；严格中间概率完整保留，不把不变集合的存在假设作结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.nonergodicSet",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem nonergodicSet :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (¬MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
    ∃ A : Set (MolecularDynamics.Chapter05Review.E n),MeasurableSet A ∧ MolecularDynamics.Chapter05Review.flowInvariant Φ A ∧ 0 < μ A ∧ μ A < 1)
```

