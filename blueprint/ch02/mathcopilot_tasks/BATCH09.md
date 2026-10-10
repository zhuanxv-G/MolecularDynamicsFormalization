# BATCH09 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.2.3-ErrorDifference
```json
{
  "source_id": "MD-2.2.3-ErrorDifference",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.3",
  "printed_page": "66",
  "pdf_page": "88",
  "statement_latex": "Taking the difference of the numerical and exact solutions, we have\n\\[\\boldsymbol z_{n+1}-\\boldsymbol z(t_{n+1})=\\mathcal G_h(\\boldsymbol z_n)-\\mathcal F_h(\\boldsymbol z(t_n)).\\tag{2.9}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际精确节点满足γ((k+1)h)=Fh(γ(kh))；数值节点由G迭代。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.errorDifference",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.errorDifference_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem errorDifference :
  ∀ n (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) h k,
    γ ((k+1 : ℕ)*h) = F h (γ (k*h)) →
    oneStepIterate G h (γ 0) (k+1) - γ ((k+1 : ℕ)*h) =
      G h (oneStepIterate G h (γ 0) k) - F h (γ (k*h))
```

### MD-2.2.3-Consistency
```json
{
  "source_id": "MD-2.2.3-Consistency",
  "kind": "definition",
  "label": null,
  "section": "2.2.3",
  "printed_page": "66–67",
  "pdf_page": "88–89",
  "statement_latex": "The first assumption is that $\\mathcal G_h$ is an $O(h^{p+1})$ approximation of $\\mathcal F_h$ in the sense that there is a constant $K\\ge0$ and a constant $\\Delta>0$ such that, for $t\\in[0,\\tau]$, we have\n\\[\\|\\mathcal F_h(\\boldsymbol z(t))-\\mathcal G_h(\\boldsymbol z(t))\\|\\le\\bar K h^{p+1},\\qquad h<\\Delta.\\tag{2.10}\\]\nThe assumption (2.10) that the local error is of order $p+1$, $p>0$, is termed the consistency of the numerical method. We say the method is consistent of order $p$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "正文K与展示式Kbar为同一局部误差界常数；δ=Δ，h>0来自本节起点。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.consistency",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def consistency {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  ∃ K ≥ 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t)-G h (γ t)‖ ≤ K*h^(p+1)
```

### MD-2.2.3-Stability
```json
{
  "source_id": "MD-2.2.3-Stability",
  "kind": "definition",
  "label": null,
  "section": "2.2.3",
  "printed_page": "66–67",
  "pdf_page": "88–89",
  "statement_latex": "To tackle the question of the growth of local error, we still must make an important assumption on $\\mathcal G_h$, namely that it satisfies a Lipschitz condition of the form\n\\[\\|\\mathcal G_h(\\boldsymbol u)-\\mathcal G_h(\\boldsymbol w)\\|\\le(1+hL)\\|\\boldsymbol u-\\boldsymbol w\\|,\\qquad\\boldsymbol u,\\boldsymbol w\\in\\mathcal D;\\ h\\le\\Delta.\\tag{2.11}\\]\nThe assumption (2.11) that the method does not increase the separation between two nearby trajectories by more than a factor of the form $1+hL$ in each step is referred to as the stability of the method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "h>0；D含实际解与假设留域的数值解；后面的除L界可选严格正L。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.stability",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def stability {n : ℕ} (G : ℝ → Q n → Q n) (D : Set (Q n)) : Prop :=
  ∃ L ≥ 0, ∃ δ > 0, ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
    ‖G h u-G h w‖ ≤ (1+h*L)*‖u-w‖
```

### MD-2.2.3-ErrorRecursion
```json
{
  "source_id": "MD-2.2.3-ErrorRecursion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.3",
  "printed_page": "67",
  "pdf_page": "89",
  "statement_latex": "then take norms and use the triangle inequality and (2.10), (2.11) to get the following recurrent inequality for the error $\\epsilon_n=\\|\\boldsymbol z_n-\\boldsymbol z(t_n)\\|$:\n\\[\\epsilon_{n+1}\\le(1+Lh)\\epsilon_n+\\bar K h^{p+1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "精确及数值节点都在D是p.66–67/PDF88–89的明确简化假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.errorRecursion",
  "reusable_proofs": [
    "MolecularDynamics.oneStep_error_recursion"
  ],
  "extra_assumptions": [
    "精确流作用直接以γ后继节点表示；一般范数空间版本含有限维实例；实数p接口覆盖自然数正阶。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem errorRecursion (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    (h L K p : ℝ) (ν : ℕ)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1))
    (n : ℕ) (hn : n < ν) :
    ‖oneStepIterate G h (γ 0) (n + 1) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤
      (1 + h * L) * ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ +
        K * h ^ (p + 1)
```

### MD-2.2.3-ErrorBound
```json
{
  "source_id": "MD-2.2.3-ErrorBound",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.3",
  "printed_page": "67",
  "pdf_page": "89",
  "statement_latex": "From this, the bound\n\\[\\epsilon_n\\le\\frac{\\bar K}{L}e^{Lnh}h^p,\\qquad n=0,1,\\ldots,\\nu,\\tag{2.12}\\]\nfollows by a straightforward calculation, for $h\\le\\Delta$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.errorBound",
  "reusable_proofs": [
    "MolecularDynamics.oneStep_error_bound"
  ],
  "extra_assumptions": [
    "h>0、L>0及K≥0显式化；L=0时可增大为正L，除零界不能字面使用；假设精确与数值留域来自原文。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem errorBound (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p
```

### MD-2.2.3-ConsistencyConvergence
```json
{
  "source_id": "MD-2.2.3-ConsistencyConvergence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.3",
  "printed_page": "67",
  "pdf_page": "89",
  "statement_latex": "This result shows that a method which is consistent of order $p$ and stable is convergent of order $p$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.consistencyConvergence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "τ,δ,L,p严格正，K≥0；D含精确及所有细网格数值解（原文明确简化前提）。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem consistencyConvergence
    (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {τ δ L K p : ℝ} (hτ : 0 < τ) (hδ : 0 < δ) (hL : 0 < L)
    (hK : 0 ≤ K) (hp : 0 < p)
    (hexact : MapsTo γ (Icc 0 τ) D)
    (hnum : ∀ ν : ℕ, 0 < ν → τ / (ν : ℝ) ≤ δ →
      ∀ n ≤ ν, oneStepIterate G (τ / (ν : ℝ)) (γ 0) n ∈ D)
    (hstable : ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
      ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ h ∈ Ioo 0 δ, ∀ t ∈ Icc 0 τ, t + h ≤ τ →
      ‖G h (γ t) - γ (t + h)‖ ≤ K * h ^ (p + 1)) :
    Tendsto (fun ν : ℕ => oneStepMaxError G (τ / (ν : ℝ)) γ ν) atTop (𝓝 0) ∧
    ∀ᶠ ν : ℕ in atTop, oneStepMaxError G (τ / (ν : ℝ)) γ ν ≤
      ((K / L) * Real.exp (L * τ)) * (τ / (ν : ℝ)) ^ p
```

### MD-2.2.3-ScalarVerlet
```json
{
  "source_id": "MD-2.2.3-ScalarVerlet",
  "kind": "definition",
  "label": "Example 2.2 (map)",
  "section": "2.2.3",
  "printed_page": "67",
  "pdf_page": "89",
  "statement_latex": "In this example, assume a single degree of freedom system, i.e. $q,p\\in\\mathbb R$, and take $M=1$. The Verlet method can be written in the form of a map, as in (2.8), or, in slightly more detail, as\n\\[Q=q+hp+\\frac{h^2}{2}F(q),\\tag{2.13}\\]\n\\[P=p+\\frac h2\\left[F(q)+F(q+hp+\\frac{h^2}{2}F(q))\\right].\\tag{2.14}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "n=1单位质量；大写Q,P为更新坐标。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_scalarVerlet",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_scalarVerlet (F : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2+h^2/2*F z.1
  (q, z.2+h/2*(F z.1+F q))
```

### MD-2.2.3-VerletExpansion
```json
{
  "source_id": "MD-2.2.3-VerletExpansion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.3",
  "printed_page": "67–68",
  "pdf_page": "89–90",
  "statement_latex": "Combining terms of like powers of $h$, we have\n\\[P=p+hF+\\frac{h^2}{2}pF'+\\frac{h^3}{4}[F'F+p^2F'']+O(h^4).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$F,F',F''$均在q取值；p.67/PDF89展开F(q+hp+h²F/2)，标量M=1。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.verletExpansion",
  "reusable_proofs": [],
  "extra_assumptions": [
    "F C³，使O(h⁴)余项有实际意义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem verletExpansion :
  ∀ (F : ℝ → ℝ) q p, ContDiff ℝ 3 F →
    Asymptotics.IsBigO (𝓝 0)
      (fun h => (scalarVerlet F h (q,p)).2 -
        (p+h*F q+h^2/2*p*deriv F q+h^3/4*(deriv F q*F q+p^2*deriv (deriv F) q)))
      (fun h : ℝ => h^4)
```

