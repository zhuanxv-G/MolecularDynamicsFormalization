# BATCH17 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.4-TimeAverage
```json
{
  "source_id": "MD-5.4-TimeAverage",
  "kind": "definition",
  "label": null,
  "section": "5.4",
  "printed_page": "195",
  "pdf_page": "216",
  "statement_latex": "Given an autonomous system of differential equations $\\dot z=f(z)$ in $\\mathbb R^m$, and a trajectory $\\tau=\\{z(t)\\mid t\\in[0,\\infty)\\}$, let $g=g(z)$ be any smooth scalar valued function of $z$ (an observable) and define (assuming it exists) the infinite time average of $g$ along $\\tau$ by\n\\[\\bar g=\\lim_{T\\to\\infty}\\frac1T\\int_0^T g(z(t))dt.\\tag{5.9}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实0..T区间积分；T>0及极限存在意义另条，T=0总化值不赋予平均意义。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.timeAverage",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

### MD-5.4-HasTimeAverage
```json
{
  "source_id": "MD-5.4-HasTimeAverage",
  "kind": "definition",
  "label": null,
  "section": "5.4",
  "printed_page": "195",
  "pdf_page": "216",
  "statement_latex": "define (assuming it exists) the infinite time average of $g$ along $\\tau$ by $\\bar g=\\lim_{T\\to\\infty}T^{-1}\\int_0^Tg(z(t))dt$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实Tendsto atTop；定义未声称所有轨道或所有可观测量必有极限。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.hasTimeAverage",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```

### MD-5.4-ConservedAverage
```json
{
  "source_id": "MD-5.4-ConservedAverage",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4",
  "printed_page": "196–197",
  "pdf_page": "217–218",
  "statement_latex": "Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $I=I(z)$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.conservedAverage",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.conservedAverage_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem conservedAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ)
    (h : ∀ t,g (z t)=a) (T : ℝ) (hT : T ≠ 0) : MolecularDynamics.Chapter05Review.timeAverage z g T=a
```

### MD-5.4-ConservedInfiniteAverage
```json
{
  "source_id": "MD-5.4-ConservedInfiniteAverage",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4",
  "printed_page": "196–197",
  "pdf_page": "217–218",
  "statement_latex": "the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. The average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留第一积分及任意依赖它的量两个无限平均结论；不只保留有限时间积分。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.conservedInfiniteAverage",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem conservedInfiniteAverage {X : Type*} (z : ℝ → X) (I : X → ℝ) (r : ℝ → ℝ)
    (hI : ∀ t,I (z t)=I (z 0)) :
  MolecularDynamics.Chapter05Review.hasTimeAverage z I (I (z 0)) ∧
    MolecularDynamics.Chapter05Review.hasTimeAverage z (r ∘ I) (r (I (z 0)))
```

### MD-5.4-DoubleWellEnergy
```json
{
  "source_id": "MD-5.4-DoubleWellEnergy",
  "kind": "definition",
  "label": "Example 5.3",
  "section": "5.4",
  "printed_page": "196",
  "pdf_page": "217",
  "statement_latex": "Example 5.3 Consider the double well potential $\\phi(q)=(1-q^2)^2$. The energy $H(q,p)=p^2/2+\\phi(q)$ will tend to $+\\infty$ as $q\\to\\infty$ or $p\\to\\infty$, but is obviously bounded below (by zero).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实二维(q,p)标量能量；非负、紧下水平集与能量面分离性质另外保留。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.doubleWellEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def doubleWellEnergy (z : MolecularDynamics.Chapter05Review.E 2) : ℝ := (z 1)^2/2+(1-(z 0)^2)^2
```

### MD-5.4-DoubleWellCoercivity
```json
{
  "source_id": "MD-5.4-DoubleWellCoercivity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4",
  "printed_page": "196",
  "pdf_page": "217",
  "statement_latex": "The energy $H(q,p)=p^2/2+(1-q^2)^2$ will tend to $+\\infty$ as $q\\to\\infty$ or $p\\to\\infty$, but is obviously bounded below (by zero).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.doubleWellCoercivity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]以所有真实下水平集的紧性表达有限维能量强制性；不是从数值图升级一般势结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem doubleWellCoercivity : (∀ z : MolecularDynamics.Chapter05Review.E 2,0 ≤ doubleWellEnergy z) ∧
  ∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c}
```

### MD-5.4-DoubleWellDisconnected
```json
{
  "source_id": "MD-5.4-DoubleWellDisconnected",
  "kind": "unnumbered_claim",
  "label": "Example 5.3",
  "section": "5.4",
  "printed_page": "196",
  "pdf_page": "217",
  "statement_latex": "From the graph it is clear that the energy surface $H(q,p)=E$ has more than one component if $0<E<1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.doubleWellDisconnected",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem doubleWellDisconnected : ∀ c ∈ Ioo (0 : ℝ) 1,
  ¬IsPreconnected (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c)
```

### MD-5.4-DoubleWellBasin
```json
{
  "source_id": "MD-5.4-DoubleWellBasin",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4",
  "printed_page": "196",
  "pdf_page": "217",
  "statement_latex": "If an initial condition is taken from one of the two basins, say with energy $E_0$, then the trajectory through that point will remain forever in the one basin, thus the averages of many quantities, if computed using the trajectory values, would not be a good approximation of the overall average at constant energy $E_0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.doubleWellBasin",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem doubleWellBasin : ∀ (z : ℝ → MolecularDynamics.Chapter05Review.E 2) c,
  Continuous z → c ∈ Ioo (0 : ℝ) 1 → (∀ t,doubleWellEnergy (z t)=c) →
  ∀ t,((z 0) 0 > 0 ∧ (z t) 0 > 0) ∨ ((z 0) 0 < 0 ∧ (z t) 0 < 0)
```

