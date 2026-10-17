# BATCH31 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.1-StochasticMatrix
```json
{
  "source_id": "MD-6.4.1-StochasticMatrix",
  "kind": "definition",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245",
  "pdf_page": "266",
  "statement_latex": "A discrete Markov Chain is a stochastic process in which, at each step, a transition is made from the current state $i$ to another $j$ selected from a given probability distribution. In the case of a finite collection of states $\\Sigma=\\{1,2,\\ldots,k\\}$, we assume that the transition probabilities $\\pi_{ij}\\in[0,1]$ are given and denote the state at time $n$ by $S_n$. Thus we have\n\\[\\Pr(S_{n+1}=j\\mid S_n=i)=\\pi_{ij}.\\]\nThe sum of the elements in row $i$ gives the probability of being in some state at time $n+1$ given that we were in state $i$ at time $n$, thus it is one.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实右随机矩阵：所有元素非负和每行和1；≤1由这两条件推出，另条显式保存。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.stochasticMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def stochasticMatrix {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop :=
  (∀ i j, 0 ≤ PiMark i j) ∧ ∀ i, ∑ j, PiMark i j = 1
```

### MD-6.4.1-FiniteDistribution
```json
{
  "source_id": "MD-6.4.1-FiniteDistribution",
  "kind": "definition",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245",
  "pdf_page": "266",
  "statement_latex": "A distribution on the state space is typically associated to a row vector $\\psi=(\\psi_1,\\psi_2,\\ldots,\\psi_k)$ with nonzero elements and which is normalized such that\n\\[\\sum_{i=1}^k\\psi_i=1.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "印刷nonzero应区分典型正权重与一般非负概率；原句完整保留，未声明字面nonzero定义网站PASS。"
    }
  ],
  "lean_decl": "MD.Ch06.finiteDistribution",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]概率权重取非负，允许零概率状态；原nonzero作为“typically”的描述而非概率的必要条件，不添加严格正初值要求。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def finiteDistribution {k : ℕ} (ψ : MolecularDynamics.Chapter06Review.V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1
```

### MD-6.4.1-FiniteEvolution
```json
{
  "source_id": "MD-6.4.1-FiniteEvolution",
  "kind": "definition",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245",
  "pdf_page": "266",
  "statement_latex": "The probability of being in state $i$ at the $n+1$st iteration, is the sum over $j$ of the probabilities of being in state $j$ multiplied by the probability of transitioning from state $j$ to state $i$, thus\n\\[\\psi_{n+1}=\\psi_n\\Pi.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际右乘Πⁿ的初值演化；n+1递推另条证明，i→j行约定不颠倒。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.finiteEvolution",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def finiteEvolution {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) (n : ℕ) : MolecularDynamics.Chapter06Review.V k :=
  Matrix.vecMul ψ (PiMark^n)
```

### MD-6.4.1-FiniteEvolutionRecurrence
```json
{
  "source_id": "MD-6.4.1-FiniteEvolutionRecurrence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245",
  "pdf_page": "266",
  "statement_latex": "\\[\\psi_{n+1}=\\psi_n\\Pi.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.finiteEvolutionRecurrence",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem finiteEvolutionRecurrence : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ)
    (initial : Fin k → ℝ) (n : ℕ),
  MolecularDynamics.Chapter06Review.finiteEvolution matrix initial (n+1)=
    Matrix.vecMul (MolecularDynamics.Chapter06Review.finiteEvolution matrix initial n) matrix
```

### MD-6.4.1-ReturnTimes
```json
{
  "source_id": "MD-6.4.1-ReturnTimes",
  "kind": "definition",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245",
  "pdf_page": "266",
  "statement_latex": "For each state of the chain, we define the number $d(i)$ to be the greatest common divisor of all integers $l$ such that $\\pi_{ii}^{(l)}>0$ (if the probability of return to state $i$ is zero, then we set $d(i)=0$).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.returnTimes",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实Πˡ正返回时间l>0，排除0步恒等阵；原gcd周期定义必须如此解读。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def returnTimes {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : Set ℕ :=
  {n | 0 < n ∧ 0 < (PiMark^n) i i}
```

### MD-6.4.1-Period
```json
{
  "source_id": "MD-6.4.1-Period",
  "kind": "definition",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245",
  "pdf_page": "266",
  "statement_latex": "For each state of the chain, we define the number $d(i)$ to be the greatest common divisor of all integers $l$ such that $\\pi_{ii}^{(l)}>0$ (if the probability of return to state $i$ is zero, then we set $d(i)=0$).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "取全部正返回时间公因子集合在ℕ的sSup；无返回时间时该集合无界，Nat的sSup值0；不把某一个返回时间误作周期。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.period",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def period {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : ℕ :=
  sSup {d : ℕ | ∀ n ∈ MolecularDynamics.Chapter06Review.returnTimes PiMark i, d ∣ n}
```

### MD-6.4.1-Aperiodic
```json
{
  "source_id": "MD-6.4.1-Aperiodic",
  "kind": "definition",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245",
  "pdf_page": "266",
  "statement_latex": "If $d(i)=1$, for all $i$ then we say that the chain is aperiodic.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.aperiodic",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def aperiodic {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i, MolecularDynamics.Chapter06Review.period PiMark i = 1
```

### MD-6.4.1-Irreducible
```json
{
  "source_id": "MD-6.4.1-Irreducible",
  "kind": "definition",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245–246",
  "pdf_page": "266–267",
  "statement_latex": "States $i$ and $j$ are said to communicate if $\\pi_{ij}^{(l_1)}>0$ and $\\pi_{ji}^{(l_2)}>0$ for some integers $l_1$ and $l_2$. This means that it is possible to reach $j$ from $i$ with positive probability and vice-versa.\nA finite state space model is irreducible if every state is reachable from every other state in a finite “time”, where time in this context refers to the number of iterations of the chain. Equivalently, we say the model is irreducible if all states communicate.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "∀i,j保证双向可达；允许i=j的0步，不将无向连接当作有向强连通。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.irreducible",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def irreducible {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i j, ∃ n : ℕ, 0 < (PiMark^n) i j
```

