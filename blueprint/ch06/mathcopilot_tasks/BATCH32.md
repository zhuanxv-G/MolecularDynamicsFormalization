# BATCH32 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.1-FiniteInvariant
```json
{
  "source_id": "MD-6.4.1-FiniteInvariant",
  "kind": "definition",
  "label": null,
  "section": "6.4.1",
  "printed_page": "246",
  "pdf_page": "267",
  "statement_latex": "An invariant distribution is a left eigenvector of $\\Pi$, having only non-negative elements, and corresponding to the eigenvalue 1. That is, an invariant distribution $\\psi^*$ satisfies\n\\[\\psi^*=\\psi^*\\Pi.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实归一化非负左特征向量；不忽略归一化或改为右向量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.finiteInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def finiteInvariant {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) : Prop :=
  MolecularDynamics.Chapter06Review.finiteDistribution ψ ∧ Matrix.vecMul ψ PiMark = ψ
```

### MD-6.4.1-FiniteErgodicity
```json
{
  "source_id": "MD-6.4.1-FiniteErgodicity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.1",
  "printed_page": "246",
  "pdf_page": "267",
  "statement_latex": "The fundamental result for Markov chains is the following: If a given Markov chain is both irreducible and aperiodic, then it can be shown that there is a unique invariant distribution $\\psi^*$ such that\n\\[\\lim_{n\\to\\infty}\\psi_n=\\psi^*,\\]\nfor arbitrary initial distribution $\\psi_0$. The convergence of an irreducible finite Markov chain to its stationary distribution can be understood through the properties of its eigenvalues by applying of the Perron-Frobenius theorem (see [269]).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.finiteErgodicity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]非空真实有限状态、右随机矩阵、全部幂Πⁿ、真实全部初始概率；完整存在、唯一性及任意初值向量收敛，不假设谱隙或收敛结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem finiteErgodicity :
  ∀ {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ),
  0 < k → MolecularDynamics.Chapter06Review.stochasticMatrix PiMark → MolecularDynamics.Chapter06Review.irreducible PiMark → MolecularDynamics.Chapter06Review.aperiodic PiMark →
  ∃ ψ : MolecularDynamics.Chapter06Review.V k, MolecularDynamics.Chapter06Review.finiteInvariant PiMark ψ ∧ (∀ χ, MolecularDynamics.Chapter06Review.finiteInvariant PiMark χ → χ=ψ) ∧
    ∀ ψ0 : MolecularDynamics.Chapter06Review.V k, MolecularDynamics.Chapter06Review.finiteDistribution ψ0 → Tendsto (MolecularDynamics.Chapter06Review.finiteEvolution PiMark ψ0) atTop (𝓝 ψ)
```

### MD-6.4.1-StochasticEntryBound
```json
{
  "source_id": "MD-6.4.1-StochasticEntryBound",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245",
  "pdf_page": "266",
  "statement_latex": "it is a matrix whose entries are all nonnegative and less than or equal to 1.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.stochasticEntryBound",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem stochasticEntryBound : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix → ∀ i j, matrix i j ≤ 1
```

### MD-6.4.1-FiniteChainExample
```json
{
  "source_id": "MD-6.4.1-FiniteChainExample",
  "kind": "definition",
  "label": "Fig. 6.6",
  "section": "6.4.1",
  "printed_page": "246",
  "pdf_page": "267",
  "statement_latex": "Fig. 6.6 A Markov matrix (left) and its graph representation (right). In this example, the Markov Chain is not irreducible.\n\\[\\Pi=\\begin{bmatrix}0.2&0.1&0.7&0&0\\\\0&0&0&1&0\\\\0.3&0&0&0.3&0.4\\\\0&0.5&0&0.3&0.2\\\\0&0&0&1&0\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原数值矩阵全项保留，decimal精确有理数；图示的非不可约数学结论另条，不列为纯定性排除。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.finiteChainExample",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def finiteChainExample : Matrix (Fin 5) (Fin 5) ℝ :=
  !![(1/5),(1/10),(7/10),0,0;
     0,0,0,1,0;
     (3/10),0,0,(3/10),(2/5);
     0,(1/2),0,(3/10),(1/5);
     0,0,0,1,0]
```

### MD-6.4.1-ExampleStochastic
```json
{
  "source_id": "MD-6.4.1-ExampleStochastic",
  "kind": "extra_claim",
  "label": null,
  "section": "6.4.1",
  "printed_page": "246",
  "pdf_page": "267",
  "statement_latex": "Fig. 6.6 A Markov matrix (left) and its graph representation (right).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.exampleStochastic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原具体数值矩阵的真实随机行资格检查。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem exampleStochastic : MolecularDynamics.Chapter06Review.stochasticMatrix finiteChainExample
```

### MD-6.4.1-ExampleNotIrreducible
```json
{
  "source_id": "MD-6.4.1-ExampleNotIrreducible",
  "kind": "unnumbered_claim",
  "label": "Fig. 6.6",
  "section": "6.4.1",
  "printed_page": "246",
  "pdf_page": "267",
  "statement_latex": "In this example, the Markov Chain is not irreducible.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.exampleNotIrreducible",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem exampleNotIrreducible : ¬ MolecularDynamics.Chapter06Review.irreducible finiteChainExample
```

### MD-6.4.1-Communicates
```json
{
  "source_id": "MD-6.4.1-Communicates",
  "kind": "definition",
  "label": null,
  "section": "6.4.1",
  "printed_page": "245–246",
  "pdf_page": "266–267",
  "statement_latex": "States $i$ and $j$ are said to communicate if $\\pi_{ij}^{(l_1)}>0$ and $\\pi_{ji}^{(l_2)}>0$ for some integers $l_1$ and $l_2$. This means that it is possible to reach $j$ from $i$ with positive probability and vice-versa.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "两个可能不同的真实有限时间及两个方向。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.communicates",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def communicates {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ) (i j : Fin k) : Prop :=
  (∃ n : ℕ, 0 < (matrix^n) i j) ∧ ∃ n : ℕ, 0 < (matrix^n) j i
```

### MD-6.4.1-DirectedGraphIrreducible
```json
{
  "source_id": "MD-6.4.1-DirectedGraphIrreducible",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.1",
  "printed_page": "246",
  "pdf_page": "267",
  "statement_latex": "Then one may understand irreducibility as expressing the connectedness of this graph.\nFor a directed graph, we must have, for any pair of vertices $A$ and $B$, paths which take us from $A$ to $B$ and vice-versa.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.directedGraphIrreducible",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实正权边与有向路径可达关系；∀i,j强连通，不用无向连通偷换。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem directedGraphIrreducible : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix →
  (MolecularDynamics.Chapter06Review.irreducible matrix ↔
    ∀ i j, Relation.ReflTransGen (fun a b ↦ 0 < matrix a b) i j)
```

