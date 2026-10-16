# BATCH14 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.2.2-RiemannTags
```json
{
  "source_id": "MD-6.2.2-RiemannTags",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "228",
  "pdf_page": "249",
  "statement_latex": "Recall that the Riemann integral of a continuous function $g$ on $[0,\\tau]$ is the limit of Riemann sums constructed as follows: partition the interval $[0,\\tau]$ into $K$ subintervals each of width $\\delta t=\\tau/K$, choose an arbitrary $t_k$ from the $k$th subinterval, $1\\leq k\\leq K$, and evaluate the integral as a limit of the sum of products:\n\\[\\int_0^\\tau g(t)dt=\\lim_{K\\to\\infty}\\sum_{k=0}^{K-1}g(t_k)\\delta t.\\]\nWe know that this limit does not depend on where the $t_k$ are chosen within the subintervals. For example we can take the left or right endpoint of each subinterval or the midpoint.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.riemannTags",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]非负窗口和所有合法任意tags；完整标签无关性，没有缩减为仅左端点特例。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem riemannTags : ∀ (g : ℝ → ℝ) (T : ℝ) (tags : ℕ → ℕ → ℝ),
  0 ≤ T → ContinuousOn g (Icc 0 T) →
  (∀ K k : ℕ, 0 < K → k < K → tags K k ∈ Icc ((k : ℝ)*T/K) (((k : ℝ)+1)*T/K)) →
  Tendsto (fun K : ℕ ↦ ∑ k ∈ Finset.range K, g (tags K k)*(T/K)) atTop
    (𝓝 (∫ t in (0 : ℝ)..T, g t))
```

### MD-6.2.2-ItoLeftSum
```json
{
  "source_id": "MD-6.2.2-ItoLeftSum",
  "kind": "definition",
  "label": null,
  "section": "6.2.2",
  "printed_page": "228",
  "pdf_page": "249",
  "statement_latex": "By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:\n\\[\\sum_{k=0}^{K-1}g(t_k)[W((k+1)\\delta t)-W(k\\delta t)],\\quad K\\to\\infty.\\]\nThe first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "取tk=kδt；真实随机有限和，不预置积分存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.itoLeftSum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def itoLeftSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g ((k : ℝ) * T / K) sample *
    (W (((k : ℝ)+1) * T / K) sample - W ((k : ℝ) * T / K) sample)
```

### MD-6.2.2-StrictItoIntegral
```json
{
  "source_id": "MD-6.2.2-StrictItoIntegral",
  "kind": "definition",
  "label": null,
  "section": "6.2.2",
  "printed_page": "228–229",
  "pdf_page": "249–250",
  "statement_latex": "By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:\n\\[\\sum_{k=0}^{K-1}g(t_k)[W((k+1)\\delta t)-W(k\\delta t)],\\quad K\\to\\infty.\\]\nThe first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.\nwhere, for a sequence of random variables, $A_K$ and a random variable $B$, we have\n\\[\\operatorname{l.i.m.}_{K\\to\\infty}A_K=B\\iff\\lim_{K\\to\\infty}\\mathbb E(A_K-B)^2=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.strictItoIntegral",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]显式所有有限和与极限的L²资格，防止Bochner非可积默认值0伪造均方收敛；真实取样和极限，不假设任何求值结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def strictItoIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)
```

### MD-6.2.2-WeakItoAlias
```json
{
  "source_id": "MD-6.2.2-WeakItoAlias",
  "kind": "definition",
  "label": null,
  "section": "6.2.2",
  "printed_page": "228–229",
  "pdf_page": "249–250",
  "statement_latex": "By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:\n\\[\\sum_{k=0}^{K-1}g(t_k)[W((k+1)\\delta t)-W(k\\delta t)],\\quad K\\to\\infty.\\]\nThe first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "既有Review定义仅要求Y∈L²及误差Bochner积分收敛，未要求各有限和L²，非可积默认积分0会掩盖错误；不得用于新PASS SDE证明。"
    }
  ],
  "lean_decl": "MD.Ch06.weakItoAlias",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def weakItoAlias {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample - Y sample)^2 ∂P) atTop (𝓝 0)
```

### MD-6.2.2-StratonovichSum
```json
{
  "source_id": "MD-6.2.2-StratonovichSum",
  "kind": "definition",
  "label": null,
  "section": "6.2.2",
  "printed_page": "228",
  "pdf_page": "249",
  "statement_latex": "By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:\n\\[\\sum_{k=0}^{K-1}g(t_k)[W((k+1)\\delta t)-W(k\\delta t)],\\quad K\\to\\infty.\\]\nThe first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实时间中点tk=(k+1/2)δt；不是端点函数值的算术均值。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.stratonovichSum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def stratonovichSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g (((k : ℝ)+1/2)*T/K) sample *
    (W (((k : ℝ)+1)*T/K) sample-W ((k : ℝ)*T/K) sample)
```

### MD-6.2.2-SelfItoFiniteIdentity
```json
{
  "source_id": "MD-6.2.2-SelfItoFiniteIdentity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.2.2",
  "printed_page": "228–229",
  "pdf_page": "249–250",
  "statement_latex": "As an example, consider the case where $g(t)=W(t)$. We suppose this to be approximated by a sum\n\\[\\int_0^\\tau W(t)dW(t)\\approx\\sum_{k=0}^{K-1}W(k\\delta t)[W((k+1)\\delta t)-W(k\\delta t)],\\]\n\\[=\\frac12\\sum_{k=0}^{K-1}[W((k+1)\\delta t)^2-W(k\\delta t)^2-(W((k+1)\\delta t)-W(k\\delta t))^2].\\]\nBreaking this into two parts, we see that the first sum telescopes to give $W(\\tau)^2$ (as $W(0)=0$).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.selfItoFiniteIdentity",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerSelfItoSum_identity"
  ],
  "extra_assumptions": [
    "[EXTRA]真实PreBrownian、K>0和AE W0=0；保存完整有限和望远镜恒等。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem selfItoFiniteIdentity {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    ∀ᵐ sample ∂P, 2 * textbookWienerSelfItoSum W T K sample =
      W T sample ^ 2 - textbookWienerQuadraticSum W T K sample
```

### MD-6.2.2-Proposition62
```json
{
  "source_id": "MD-6.2.2-Proposition62",
  "kind": "proposition",
  "label": "Proposition 6.2",
  "section": "6.2.2",
  "printed_page": "229–230",
  "pdf_page": "250–251",
  "statement_latex": "Proposition 6.2 Let $\\delta t=\\tau/K$ then\n\\[\\operatorname{l.i.m.}_{K\\to\\infty}\\sum_{k=0}^{K-1}[(W((k+1)\\delta t)-W(k\\delta t))^2]=\\tau,\\]\nwhere, for a sequence of random variables, $A_K$ and a random variable $B$, we have\n\\[\\operatorname{l.i.m.}_{K\\to\\infty}A_K=B\\iff\\lim_{K\\to\\infty}\\mathbb E(A_K-B)^2=0.\\]\n(This is referred to as convergence in the mean square sense.)",
  "proof_latex": "With $\\tau,K$ fixed, we have $\\delta t=\\tau/K$.\nLet $W_{K,k}=W((k+1)\\delta t)-W(k\\delta t)=W((k+1)\\tau/K)-W(k\\tau/K)$ and observe that\n\\[\\sum_{k=0}^{K-1}W_{K,k}^2-\\tau=\\sum_{k=0}^{K-1}[W_{K,k}^2-\\delta t].\\]\nThen\n\\[I\\stackrel{\\rm def}=\\mathbb E(\\sum_{k=0}^{K-1}W_{K,k}^2-\\tau)^2=\\mathbb E(\\sum_{k=0}^{K-1}[W_{K,k}^2-\\delta t])^2.\\]\nTerms of the form $Z_{K,k}\\stackrel{\\rm def}=W_{K,k}^2-\\delta t$ are independent and have mean zero. Therefore\n\\[\\mathbb E(\\sum_{k=0}^{K-1}Z_{K,k})^2=\\mathbb E\\sum_{k=0}^{K-1}Z_{K,k}^2-2\\mathbb E\\sum_{k\\ne l}Z_{K,k}Z_{K,l}=\\mathbb E\\sum_{k=0}^{K-1}Z_{K,k}^2,\\]\nwhere the last equation follows from independence of the increments ($\\mathbb E Z_kZ_l=0$ if $k\\ne l$).\nAlso observe that $\\Delta W_k$ is a normally distributed random variable with the following properties\n\\[\\mathbb E\\Delta W_k=0;\\quad\\mathbb E\\Delta W_k^2=\\delta t=\\tau/K;\\quad\\mathbb E\\Delta W_k^4=3\\delta t^2=3(\\tau/K)^2.\\]\nThus we have\n\\[I=\\sum_{k=0}^{K-1}\\mathbb E(\\Delta W_{K,k}^2-\\delta t)^2\n=\\sum_{k=0}^{K-1}\\mathbb E[\\Delta W_{K,k}^4-2\\delta t\\Delta W_{K,k}^2+\\delta t^2]\n=\\sum_{k=0}^{K-1}[3\\delta t^2-2\\delta t^2+\\delta t^2]=2K\\delta t^2=2\\tau^2/K.\\]\nThus $I\\to0$ as $K\\to0$, which is the desired result.",
  "proof_note": "逐字保存含印刷负号与K→0；正式桥接使用正确独立平方和及K→∞。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "印刷证明的独立交叉项展开带负号；平方展开应正号，见单独疑误条。"
    }
  ],
  "lean_decl": "MD.Ch06.proposition62",
  "reusable_proofs": [
    "MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto"
  ],
  "extra_assumptions": [
    "[EXTRA]实际PreBrownian law、τ≥0、全部均方极限；印刷最后K→0是笔误，更正K→∞。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem proposition62 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0)
```

### MD-6.2.2-MeanSquareConvergence
```json
{
  "source_id": "MD-6.2.2-MeanSquareConvergence",
  "kind": "definition",
  "label": null,
  "section": "6.2.2",
  "printed_page": "229",
  "pdf_page": "250",
  "statement_latex": "where, for a sequence of random variables, $A_K$ and a random variable $B$, we have\n\\[\\operatorname{l.i.m.}_{K\\to\\infty}A_K=B\\iff\\lim_{K\\to\\infty}\\mathbb E(A_K-B)^2=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.meanSquareConvergence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]显式L²随机变量资格防止非可积Bochner默认值；不假设收敛结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def meanSquareConvergence {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (A : ℕ → Ω → ℝ) (B : Ω → ℝ) : Prop :=
  (∀ K, MemLp (A K) 2 P) ∧ MemLp B 2 P ∧
  Tendsto (fun K ↦ ∫ sample, (A K sample-B sample)^2 ∂P) atTop (𝓝 0)
```

