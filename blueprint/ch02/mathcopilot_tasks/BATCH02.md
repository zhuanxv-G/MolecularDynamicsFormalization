# BATCH02 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.1-Convergence
```json
{
  "source_id": "MD-2.1-Convergence",
  "kind": "definition",
  "label": null,
  "section": "2.1",
  "printed_page": "55",
  "pdf_page": "77",
  "statement_latex": "The convergence of a numerical method refers to the ability of the method to provide an arbitrary level of accuracy by using small enough timesteps.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "固定有限时间窗$[0,\\tau]$，$h=\\tau/\\nu$，最大节点误差见p.56/PDF78。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.convergence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "按固定时间窗网格h=τ/ν表达任意精度；τ>0在具体定理中明示。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def convergence {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  Tendsto (fun ν : ℕ => oneStepMaxError G (τ / ν) γ ν) atTop (𝓝 0)
```

### MD-2.1-Order
```json
{
  "source_id": "MD-2.1-Order",
  "kind": "definition",
  "label": null,
  "section": "2.1",
  "printed_page": "55",
  "pdf_page": "77",
  "statement_latex": "The order of accuracy is the exponent in the power law by which the error in the method is related to the stepsize. For example, when we say that a method is third order accurate, we mean that the global error (on a fixed finite time interval) can be bounded by $Kh^3$, where $h$ is a sufficiently small timestep and $K$ is a number which depends on the length of the time interval and the features of the problem, but which is independent of $h$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$r=3$为原文例子；定义扩展到一般自然数阶$r$，$h=\\tau/\\nu$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.order",
  "reusable_proofs": [],
  "extra_assumptions": [
    "自然数阶r；ν₀>0避免零除；K选择严格正不损失误差上界。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def order {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (r : ℕ) : Prop :=
  ∃ K > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
    oneStepMaxError G (τ / ν) γ ν ≤ K * (τ / ν)^r
```

### MD-2.1-Error
```json
{
  "source_id": "MD-2.1-Error",
  "kind": "definition",
  "label": null,
  "section": "2.1",
  "printed_page": "56",
  "pdf_page": "78",
  "statement_latex": "Let the approximate solution vectors at successive timesteps be $\\boldsymbol z_0,\\boldsymbol z_1,\\ldots,\\boldsymbol z_\\nu$ where $\\nu h=\\tau$. We assume that $\\tau$, the length of the time interval, is fixed, and $\\nu$ is an integer parameter representing the total number of timesteps. In order to improve the quality of the approximation, the parameter $\\nu$ may be increased, as the stepsize is proportionately decreased. The error at step $n$ is defined by $e_n=\\|\\boldsymbol z_n-\\boldsymbol z(t_n)\\|$, where $t_n=nh$; it clearly depends on $h$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\bar e=\\max_{0\\le n\\le\\nu} e_n$来自紧接Theorem2.1；$t_n=nh$，含n=0。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.maximumError",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def maximumError {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G : ℝ → E → E) (γ : ℝ → E) (h : ℝ) (ν : ℕ) : ℝ :=
  oneStepMaxError G h γ ν
```

### MD-2.1-Thm2.1
```json
{
  "source_id": "MD-2.1-Thm2.1",
  "kind": "theorem",
  "label": "Theorem 2.1",
  "section": "2.1",
  "printed_page": "56",
  "pdf_page": "78",
  "statement_latex": "Let $\\mathcal D$ be a bounded, open region in $\\mathbb R^m$ such that $f:\\mathcal D\\to\\mathbb R^m$ is continuously differentiable. Let $\\boldsymbol\\zeta$ be an interior point of $\\mathcal D$ and suppose the initial value problem (2.1) has a unique solution that remains in $\\mathcal D$ for $t\\in[0,\\tau]$. Then there exists a constant $C(\\tau)>0$ such that for sufficiently large $\\nu\\in\\mathbb N$ the numerical solution $\\boldsymbol z_n$ remains in $\\mathcal D$ for $n=0,1,\\ldots,\\nu$, where $h\\nu=\\tau$, and, moreover, the maximum global error in Euler’s method satisfies\n\\[\\bar e:=\\max_{0\\le n\\le\\nu}e_n\\le C(\\tau)h.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\zeta=\\gamma(0)$，$e_n$和$h=\\tau/\\nu$见同页上段；Euler单步见p.54/PDF76。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.theorem_2_1",
  "reusable_proofs": [
    "MolecularDynamics.theorem_2_1_euler"
  ],
  "extra_assumptions": [
    "时间长度τ≥0显式化；f以环境全函数表示，只在开放D上要求C¹。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem theorem_2_1 {m : ℕ} (D : Set (Position m))
    (hDb : Bornology.IsBounded D) (hD : IsOpen D)
    (f : Position m → Position m) (hf : ContDiffOn ℝ 1 f D)
    (γ : ℝ → Position m) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t)
    (_hunique : ∀ η : ℝ → Position m, η 0 = γ 0 → MapsTo η (Icc 0 τ) D →
      (∀ t ∈ Icc 0 τ, HasDerivWithinAt η (f (η t)) (Icc 0 τ) t) →
      ∀ t ∈ Icc 0 τ, η t = γ t) :
    ∃ C : ℝ, 0 < C ∧ ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      (∀ n ≤ ν, eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D) ∧
        eulerMaxError f (τ / (ν : ℝ)) γ ν ≤ C * (τ / (ν : ℝ))
```

