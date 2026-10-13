# BATCH11 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.2.1-RademacherJumps
```json
{
  "source_id": "MD-6.2.1-RademacherJumps",
  "kind": "definition",
  "label": null,
  "section": "6.2.1",
  "printed_page": "225",
  "pdf_page": "246",
  "statement_latex": "In the classic model of a random walk the jump takes values $\\pm1$ with equal probability.\nThe increments of the random walk are the differences $\\Delta X_n=X_n-X_{n-1}=\\delta xJ_{n-1}$, thus $(X_n)$ is a random process with independent increments.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.rademacherJumps",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实概率空间、独立可测L²跳跃、AE取±1且期望零；这些条件保留公平Rademacher意义，不把二阶有限和结论作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rademacherJumps {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun J P ∧ ∀ k,
    Measurable (J k) ∧ MemLp (J k) 2 P ∧
    (∀ᵐ sample ∂P, J k sample = 1 ∨ J k sample = -1) ∧ (∫ sample, J k sample ∂P) = 0
```

### MD-6.2.1-RandomWalk
```json
{
  "source_id": "MD-6.2.1-RandomWalk",
  "kind": "definition",
  "label": null,
  "section": "6.2.1",
  "printed_page": "225",
  "pdf_page": "246",
  "statement_latex": "That is, we have\n\\[X_{n+1}=X_n+\\delta x J_n.\\]\nWe initiate the random walk with $X_0=0$.\nThe solution $X_n$ of the random walk may be written\n\\[X_n=\\delta x\\sum_{k=0}^{n-1}J_k.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实n项Finset.range n有限和；递推、初值及独立增量另列，不计为定义自动证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.randomWalk",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def randomWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  dx * ∑ k ∈ Finset.range n, J k sample
```

### MD-6.2.1-WalkRecurrence
```json
{
  "source_id": "MD-6.2.1-WalkRecurrence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "225",
  "pdf_page": "246",
  "statement_latex": "A random walk is a discrete stochastic process in which the state $X_n$ at a given instant (defined by the index $n$) is related to the state $X_{n-1}$, at step $n-1$ by an offset that may be viewed as a random variable. That is, we have\n\\[X_{n+1}=X_n+\\delta x J_n.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.walkRecurrence",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem walkRecurrence :
  ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.randomWalk J dx (n+1) sample = MolecularDynamics.Chapter06Review.randomWalk J dx n sample + dx*J n sample
```

### MD-6.2.1-WalkInitial
```json
{
  "source_id": "MD-6.2.1-WalkInitial",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "225",
  "pdf_page": "246",
  "statement_latex": "We initiate the random walk with $X_0=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.walkInitial",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem walkInitial : ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (sample : Ω),
  MolecularDynamics.Chapter06Review.randomWalk J dx 0 sample = 0
```

### MD-6.2.1-WalkVariance
```json
{
  "source_id": "MD-6.2.1-WalkVariance",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.1",
  "printed_page": "225–226",
  "pdf_page": "246–247",
  "statement_latex": "hence the variance is\n\\[\\mathbb E X_n^2=\\delta x^2\\mathbb E\\left(\\sum_{k=0}^{n-1}J_k\\right)^2.\\]\nExpanding the squared sum we see that there are (i) $n$ squares $J_k^2$ plus (ii) products of the form $J_kJ_l$, $k\\neq l$. Clearly the former are always one and the latter have zero expectation, thus\n\\[\\mathbb E X_n^2=n\\delta x^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.walkVariance",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整真实概率、L²、独立且公平±1跳跃；同时保存零均值与原完整二阶矩，不将和的二阶矩或交叉项零作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem walkVariance :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ), MolecularDynamics.Chapter06Review.rademacherJumps P J →
  (∫ sample, MolecularDynamics.Chapter06Review.randomWalk J dx n sample ∂P) = 0 ∧ (∫ sample, MolecularDynamics.Chapter06Review.randomWalk J dx n sample ^ 2 ∂P) = n*dx^2
```

### MD-6.2.1-DiffusiveWalk
```json
{
  "source_id": "MD-6.2.1-DiffusiveWalk",
  "kind": "definition",
  "label": null,
  "section": "6.2.1",
  "printed_page": "226",
  "pdf_page": "247",
  "statement_latex": "Let $t_n=n\\delta t$, $n=0,1,\\ldots,\\nu$ and define\n\\[Y(t_{k+1})=Y(t_k)+\\sqrt{\\delta t}J_k,\\qquad k=0,1,\\ldots,\\nu-1,\\]\nwhere $Y(0)=0$. Effectively we are making the size of the jump $\\delta x$ taken at each step of the random walk equal to $\\sqrt{\\delta t}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "δt>0；Yk是真实随机游走取δx=√δt；连续时间插值另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.diffusiveWalk",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def diffusiveWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt : ℝ) : ℕ → Ω → ℝ :=
  MolecularDynamics.Chapter06Review.randomWalk J (Real.sqrt dt)
```

### MD-6.2.1-InterpolatedWalk
```json
{
  "source_id": "MD-6.2.1-InterpolatedWalk",
  "kind": "definition",
  "label": null,
  "section": "6.2.1",
  "printed_page": "226",
  "pdf_page": "247",
  "statement_latex": "For points between $t_k$ and $t_{k+1}$ we define the value of $Y(t)$ by linear interpolation:\n\\[Y(t)=Y_k+\\Delta Y_k\\frac{t-t_k}{\\delta t}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "δt>0，k=⌊t/δt⌋，真实线性插值；不是Wiener路径，也不声称任意插值点方差恰等于时间差。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.interpolatedWalk",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def interpolatedWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt t : ℝ) (sample : Ω) : ℝ :=
  let n := Nat.floor (t / dt)
  MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample + (t - n * dt) / dt *
    (MolecularDynamics.Chapter06Review.diffusiveWalk J dt (n+1) sample - MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample)
```

### MD-6.2.1-WalkIncrement
```json
{
  "source_id": "MD-6.2.1-WalkIncrement",
  "kind": "definition",
  "label": null,
  "section": "6.2.1",
  "printed_page": "225–226",
  "pdf_page": "246–247",
  "statement_latex": "The increments of the random walk are the differences $\\Delta X_n=X_n-X_{n-1}=\\delta xJ_{n-1}$, thus $(X_n)$ is a random process with independent increments.\nWe will use the shorthand $Y_k=Y(t_k)$ and $\\Delta Y_k=Y_{k+1}-Y_k=\\sqrt{\\delta t}J_k$. The increments are clearly independent.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条定义实际X(n+1)−Xn增量；差分恒等式与独立性另条保存，不把独立性计为定义已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.walkIncrement",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def walkIncrement {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  MolecularDynamics.Chapter06Review.randomWalk J dx (n+1) sample - MolecularDynamics.Chapter06Review.randomWalk J dx n sample
```

