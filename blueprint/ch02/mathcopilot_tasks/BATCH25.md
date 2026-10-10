# BATCH25 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.4.4-ImplicitLocal
```json
{
  "source_id": "MD-2.4.4-ImplicitLocal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.4",
  "printed_page": "86",
  "pdf_page": "108",
  "statement_latex": "An implicit method will typically result in a system of nonlinear equations of the form\n\\[g(\\boldsymbol z_{n+1})=\\boldsymbol\\tau_n,\\tag{2.25}\\]\nwhich will need to be solved at each timestep. The right hand $\\boldsymbol\\tau_n$ is a vector that depends on the previous time-step $\\boldsymbol z_n$, perhaps in a complicated way. We may assume the number of equations represented by (2.25) is equal to the dimension of the phase space where $\\boldsymbol z$ is defined, so we have a square nonlinear system. Typically $g$ will depend on the stepsize and coefficients of the method and will have the property that for $h$ sufficiently small, the solution is uniquely defined and is continuously defined in terms of $\\boldsymbol\\tau_n$, that is the mapping $g$ has a bounded and smooth inverse.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.implicitLocal",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]g依赖真实步长h；联合C∞，零步实际导数为连续线性同构。",
    "[EXTRA]结论为充分小步长的局部逆；缩小有界邻域，不宣称全域有界逆。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem implicitLocal : ∀ n (g : ℝ → Q n → Q n) x
    (A : Q n ≃L[ℝ] Q n), ContDiff ℝ ∞ (Function.uncurry g) →
    HasFDerivAt (g 0) A.toContinuousLinearMap x →
    ∃ δ > 0, ∀ h : ℝ, |h| < δ → ∃ U V : Set (Q n),
      IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ ∞ inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧
        (∀ y ∈ V, inv y ∈ U ∧ g h (inv y)=y) ∧
        (∀ y ∈ U, inv (g h y)=y)
```

### MD-2.4.4-BackwardEulerSolve
```json
{
  "source_id": "MD-2.4.4-BackwardEulerSolve",
  "kind": "definition",
  "label": "Example 2.6",
  "section": "2.4.4",
  "printed_page": "86",
  "pdf_page": "108",
  "statement_latex": "The Backward Euler method,\n\\[\\boldsymbol z_{n+1}=\\boldsymbol z_n+hf(\\boldsymbol z_{n+1}),\\]\nis an example of an implicit method. The calculation of a timestep involves solving a system of equations of the form\n\\[g(\\boldsymbol w)=\\boldsymbol w-\\boldsymbol z_n-hf(\\boldsymbol w)=\\boldsymbol0.\\]\nThe map $\\mathcal G_h$ is defined implicitly by the equation\n\\[\\mathcal G_h(\\boldsymbol z)=\\boldsymbol z+hf(\\mathcal G_h(\\boldsymbol z)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "零点即隐式步关系；没有断言每个f/h存在唯一零点。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.backwardEulerResidual",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def backwardEulerResidual (f : E → E) (h : ℝ) (z w : E) : E := w-z-h • f w
```

### MD-2.4.4-Newton
```json
{
  "source_id": "MD-2.4.4-Newton",
  "kind": "definition",
  "label": null,
  "section": "2.4.4",
  "printed_page": "86–87",
  "pdf_page": "108–109",
  "statement_latex": "Solving the system may proceed from an initial guess $\\boldsymbol z_{n+1}^{(0)}$ by use of Newton’s method:\n\\[\\boldsymbol z_{n+1}^{(k+1)}=\\boldsymbol z_{n+1}^{(k)}-[J^{(k)}]^{-1}(g(\\boldsymbol z_n^{(k)})-\\boldsymbol\\tau_n),\\]\nwhere $J^{(k)}$ is the Jacobian matrix of the mapping $g$ evaluated at $\\boldsymbol z_n^{(k)}$, or else an approximation of this Jacobian (assumed to be nonsingular due to the invertibility of the mapping). The iteration may be recast in the form\n\\[\\boldsymbol b_k=-(g(\\boldsymbol z_n^{(k)})-\\boldsymbol\\tau_n),\\quad J^{(k)}\\Delta\\boldsymbol z_k=\\boldsymbol b_k,\\quad\\boldsymbol z_{n+1}^{(k+1)}=\\boldsymbol z_{n+1}^{(k)}+\\Delta\\boldsymbol z_k.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文混用zₙ⁽ᵏ⁾与zₙ₊₁⁽ᵏ⁾；保留两个不同输入，不静默改成相同迭代点。映射可逆也不保证任意近似Jacobian非奇异。"
    }
  ],
  "lean_decl": "MD.Ch02.newtonPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def newtonPrinted {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)
```

### MD-2.4.4-NewtonQuadratic
```json
{
  "source_id": "MD-2.4.4-NewtonQuadratic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.4",
  "printed_page": "87",
  "pdf_page": "109",
  "statement_latex": "Newton’s method (without approximation of the Jacobian matrix) has a remarkable quadratic convergence property, meaning that, when the initial guess is close to the solution, the errors $e_k,e_{k+1}$ at the $k$th and $k+1$st iterations satisfy the relation\n\\[e_{k+1}\\le Ke_k^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "标准Newton的同一个迭代点，前项字面索引疑点另列；e=‖y−x*‖。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.newtonQuadratic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem newtonQuadratic :
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n),
    ContDiff ℝ 2 g → g x = 0 → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ C > 0, ∃ δ > 0, ∀ y : Q n, ‖y-x‖ < δ →
      ∃ B : Q n ≃L[ℝ] Q n, HasFDerivAt g B.toContinuousLinearMap y ∧ ‖newtonStep g 0 y B-x‖ ≤ C*‖y-x‖^2
```

### MD-2.4.4-FrozenNewton
```json
{
  "source_id": "MD-2.4.4-FrozenNewton",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.4",
  "printed_page": "87",
  "pdf_page": "109",
  "statement_latex": "For example, if the Jacobian matrix is large and can be written in the form\n\\[J(\\boldsymbol z)=D+E(\\boldsymbol z),\\]\nwhere $E$ is small in norm and $D$ is a constant sparse matrix, then, in many cases, the Jacobian matrix may be replaced by the constant matrix $D$ and the iteration will still converge.\nThis rapid convergence is typically lost when the Jacobian matrix is approximated in some way, and one finds instead\n\\[e_{k+1}\\le\\rho e_k,\\]\nwhere $0<\\rho<1$, i.e., quadratic convergence is replaced by geometric convergence.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.frozenNewton",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]固定D连续线性同构，邻域内实际I−D⁻¹g′范数≤ρ<1，ρ>0；精确可核的small资格，未声称任意近似Jacobian都收敛。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem frozenNewton :
  ∀ n (g : Q n → Q n) (A : Q n ≃L[ℝ] Q n) x δ ρ,
    g x = 0 → 0 < δ → 0 < ρ → ρ < 1 → ContDiff ℝ 1 g →
    (∀ y ∈ Metric.ball x δ, ‖ContinuousLinearMap.id ℝ (Q n)-A.symm.toContinuousLinearMap.comp (fderiv ℝ g y)‖ ≤ ρ) →
    ∀ y ∈ Metric.ball x δ, ‖newtonStep g 0 y A-x‖ ≤ ρ*‖y-x‖
```

