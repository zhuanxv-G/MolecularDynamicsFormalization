# BATCH07 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.2.2-DiscretePath
```json
{
  "source_id": "MD-2.2.2-DiscretePath",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "63",
  "pdf_page": "85",
  "statement_latex": "We work on the time interval $[0,\\tau]$. Consider the $\\nu+1$ points $\\boldsymbol q_0$ to $\\boldsymbol q_\\nu$ in configuration space\n\\[\\hat\\Gamma=(\\boldsymbol q_0,\\boldsymbol q_1,\\ldots,\\boldsymbol q_\\nu).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "ν为正整数，νh=τ；端点固定的变分见后文。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.finiteDiscretePath",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def finiteDiscretePath (n ν : ℕ) := Fin (ν+1) → Q n
```

### MD-2.2.2-DiscreteVelocity
```json
{
  "source_id": "MD-2.2.2-DiscreteVelocity",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "63",
  "pdf_page": "85",
  "statement_latex": "we are led to consider the approximation at time level $n$\n\\[\\boldsymbol v_n\\stackrel{\\rm def}{=}\\frac{\\boldsymbol q_{n+1}-\\boldsymbol q_n}{h},\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "h>0，n<ν；总函数接口仅在该网格范围使用。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_discreteVelocity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_discreteVelocity {n : ℕ} (q : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  h⁻¹ • (q (k+1) - q k)
```

### MD-2.2.2-DiscreteAction
```json
{
  "source_id": "MD-2.2.2-DiscreteAction",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "63",
  "pdf_page": "85",
  "statement_latex": "and thus, by Riemann summation\n\\[\\mathcal A_L\\approx\\hat{\\mathcal A}\\stackrel{\\rm def}{=}\\sum_{n=0}^{\\nu-1} L\\left(\\boldsymbol q_n,\\frac{\\boldsymbol q_{n+1}-\\boldsymbol q_n}{h}\\right)h.\\]\nIn the case of a mechanical system with Lagrangian $L(\\boldsymbol q,\\boldsymbol v)=\\dot{\\boldsymbol v}^TM\\boldsymbol v/2+U(\\boldsymbol q)$, we then have\n\\[\\hat{\\mathcal A}=\\sum_{n=0}^{\\nu-1}\\left[\\frac{(\\boldsymbol q_{n+1}-\\boldsymbol q_n)^TM(\\boldsymbol q_{n+1}-\\boldsymbol q_n)}{2h^2}-U(\\boldsymbol q_n)\\right]h.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "正文L写v上方点且+U，与p.60/PDF82和紧接展示离散作用量的-U冲突；定义只登记一般L离散求和，不把两种机械式同时认作正确。"
    }
  ],
  "lean_decl": "MD.Ch02.bp_discreteAction",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_discreteAction {n : ℕ} (L : Q n → Q n → ℝ) (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : ℝ :=
  ∑ k ∈ Finset.range ν, h * L (q k) (discreteVelocity q h k)
```

### MD-2.2.2-DiscreteStationaryPrinted
```json
{
  "source_id": "MD-2.2.2-DiscreteStationaryPrinted",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "63–64",
  "pdf_page": "85–86",
  "statement_latex": "Critical points of this function satisfy\n\\[\\nabla\\hat{\\mathcal A}=0,\\]\nwhere the gradient must be taken with respect to all configurational points on the path (and all coordinates). This condition leads to the equations\n\\[\\frac{\\partial\\hat{\\mathcal A}}{\\partial\\boldsymbol q_n}=0,\\qquad n=1,\\ldots,\\nu,\\]\nsince we think of the starting point $\\boldsymbol q_0$ as fixed.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原页n=1,…,ν包含右端点，后页说端点固定且只对1,…,ν-1求导。保留字面≤ν，不默改为<ν。"
    }
  ],
  "lean_decl": "MD.Ch02.printedDiscreteStationary",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def printedDiscreteStationary {n : ℕ} (L : Q n → Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k ≤ ν →
    fderiv ℝ (fun x => discreteAction L (replaceNode q k x) h ν) (q k) = 0
```

### MD-2.2.2-DiscreteDerivative
```json
{
  "source_id": "MD-2.2.2-DiscreteDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.2",
  "printed_page": "64",
  "pdf_page": "86",
  "statement_latex": "To calculate the derivative of $\\hat{\\mathcal A}$ with respect to $\\boldsymbol q_n$, $n=1,2,\\ldots,\\nu-1$, note that only a few terms of the discrete action involve this configurational point, thus\n\\[\\frac{\\partial\\hat{\\mathcal A}}{\\partial\\boldsymbol q_n}=\\frac1h[M(\\boldsymbol q_n-\\boldsymbol q_{n-1})-M(\\boldsymbol q_{n+1}-\\boldsymbol q_n)]-\\nabla U(\\boldsymbol q_n)h,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.discreteActionDerivative",
  "reusable_proofs": [],
  "extra_assumptions": [
    "固定正对角质量、实际U可微、h≠0；仅内部节点0<k<ν；沿p.60及p.63展示的-U作用量。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem discreteActionDerivative :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν k,
    positiveMass m → Differentiable ℝ U → h ≠ 0 → 0 < k → k < ν →
    ∀ v : Q n,
      (fderiv ℝ (fun x => discreteAction (mechanicalL m U) (replaceNode q k x) h ν) (q k)) v =
        ∑ i, (m i * (2*q k i-q (k-1) i-q (k+1) i)/h-h*grad U (q k) i) * v i
```

### MD-2.2.2-DiscreteVerlet
```json
{
  "source_id": "MD-2.2.2-DiscreteVerlet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.2",
  "printed_page": "64",
  "pdf_page": "86",
  "statement_latex": "which yields the equations\n\\[M(\\boldsymbol q_{n+1}-2\\boldsymbol q_n+\\boldsymbol q_{n-1})=-h^2\\nabla U(\\boldsymbol q_n),\\qquad n=1,2,\\ldots,\\nu-1.\\tag{2.4}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "端点固定，只对内部节点驻值；L按p.60的-U版本。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.discreteStationaryVerlet",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正对角质量、U可微、h≠0。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem discreteStationaryVerlet :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν,
    positiveMass m → Differentiable ℝ U → h ≠ 0 →
    (discreteStationary (mechanicalL m U) q h ν ↔
      ∀ k, 0 < k → k < ν → stormerRelation m (fun x => -grad U x) h (q (k-1)) (q k) (q (k+1)))
```

### MD-2.2.2-Stormer
```json
{
  "source_id": "MD-2.2.2-Stormer",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "64",
  "pdf_page": "86",
  "statement_latex": "The method (2.4) is commonly referred to as Störmer’s rule.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "式(2.4)为$M(q_{n+1}-2q_n+q_{n-1})=h^2F(q_n)$；p.93/PDF115再以消元给同一递推。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_stormerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_stormerRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (a b c : Q n) : Prop :=
  c - (2 : ℝ) • b + a = h^2 • invMass m (F b)
```

### MD-2.2.2-VelocityVerlet
```json
{
  "source_id": "MD-2.2.2-VelocityVerlet",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "64",
  "pdf_page": "86",
  "statement_latex": "The scheme is usually given in an alternative “velocity Verlet” form that takes a step from a given vector $\\boldsymbol q_n,\\boldsymbol v_n$ to $\\boldsymbol q_{n+1},\\boldsymbol v_{n+1}$ by the sequence of operations\n\\[\\boldsymbol v_{n+1/2}=\\boldsymbol v_n+(h/2)M^{-1}F_n,\\tag{2.5}\\]\n\\[\\boldsymbol q_{n+1}=\\boldsymbol q_n+h\\boldsymbol v_{n+1/2},\\tag{2.6}\\]\n\\[\\boldsymbol v_{n+1}=\\boldsymbol v_{n+1/2}+(h/2)M^{-1}F_{n+1},\\tag{2.7}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Fn=F(qn)=-∇U(qn)，p.65/PDF87；输入第二分量为速度v而非动量p。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_velocityVerlet",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_velocityVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vhalf := z.2 + (h/2) • invMass m (F z.1)
  let qnew := z.1 + h • vhalf
  (qnew, vhalf + (h/2) • invMass m (F qnew))
```

