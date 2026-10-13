# BATCH17 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3-BiasedWalk
```json
{
  "source_id": "MD-6.3-BiasedWalk",
  "kind": "definition",
  "label": "(6.9)",
  "section": "6.3",
  "printed_page": "232",
  "pdf_page": "253",
  "statement_latex": "We introduce a pair of smooth functions $a(x,t)$ and $b(x,t)$, where $a$ represents a drift tendency and $b$ the average magnitude of the random jump. In the interval $[n\\delta t,(n+1)\\delta t]$, a step $\\delta X_n=X_{n+1}-X_n$ of the random walk will be given by\n\\[\\delta X_n=a(X_n,t_n)h+b(X_n,t_n)J_n\\delta x.\\tag{6.9}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.biasedWalk",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]按正文h=δt及δx=√δt解释真实递归与x0初值；印刷h/δt记号不一致已保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def biasedWalk {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | n+1 => fun sample ↦ let x := MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 n sample
    x + a x (n * dt) * dt + b x (n * dt) * Real.sqrt dt * J n sample
```

### MD-6.3-BiasedWalkSum
```json
{
  "source_id": "MD-6.3-BiasedWalkSum",
  "kind": "unnumbered_claim",
  "label": "(6.10)",
  "section": "6.3",
  "printed_page": "232",
  "pdf_page": "253",
  "statement_latex": "Choose a positive $t$ and sum (6.9) from $n=0$ to $\\nu-1$, where $\\nu=\\lfloor t/\\delta t\\rfloor$, obtaining\n\\[X_\\nu-X_0=\\sum_{n=0}^{\\nu-1}\\delta X_n=\\sum_{n=0}^{\\nu-1}a(X_n,t_n)\\delta t+\\sum_{n=0}^{\\nu-1}b(X_n,t_n)J_n\\delta x.\\tag{6.10}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.biasedWalkSum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem biasedWalkSum : ∀ {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) (K : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 K sample-x0 =
    (∑ k ∈ Finset.range K, a (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*dt) +
    ∑ k ∈ Finset.range K, b (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*Real.sqrt dt*J k sample
```

### MD-6.3-ScalarSDE
```json
{
  "source_id": "MD-6.3-ScalarSDE",
  "kind": "definition",
  "label": "(6.11)–(6.14)",
  "section": "6.3",
  "printed_page": "232",
  "pdf_page": "253",
  "statement_latex": "Take the diffusion limit $\\delta t\\to0$, $\\delta x^2/\\delta t\\to1$ with $\\nu\\delta t=t$ fixed, then we obtain, under the Itô convention,\n\\[X(t)-X(0)=\\int_0^t a(X(s),s)ds+\\int_0^t b(X(s),s)dW(s).\\tag{6.11}\\]\n\\[dX=a(X,t)dt+b(X,t)dW.\\tag{6.14}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "(6.12)漂移为普通时间积分；(6.13)为左点均方极限；连续微分并非普通样本导数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.strictScalarSDE",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实连续路径、实际可积漂移及全部有限和L²的Ito极限；是方程意义，不计随机游走扩散极限已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def strictScalarSDE {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ T : ℝ, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s) volume 0 T) ∧
    strictItoIntegral P W (fun s sample ↦ b (X s sample) s) T
      (fun sample ↦ X T sample-x0-∫ s in 0..T, a (X s sample) s)
```

### MD-6.3-VectorSDE
```json
{
  "source_id": "MD-6.3-VectorSDE",
  "kind": "definition",
  "label": "(6.15)–(6.16)",
  "section": "6.3",
  "printed_page": "232–233",
  "pdf_page": "253–254",
  "statement_latex": "Let $a(z,t)$ and $b^{(i)}(z,t)$, $i=1,2,\\ldots,r$ be a set of $r+1$ vector fields in $\\mathbb R^m$, and let $W_1,W_2,\\ldots,W_r$ be a collection of $r$ independent Wiener processes, then we may write a system of SDEs in $\\mathbb R^m$ in the form\n\\[dZ=a(Z,t)dt+\\sum_{i=1}^r b^{(i)}(Z,t)dW_i.\\tag{6.15}\\]\nalternatively, if $B$ is the matrix with columns $b^{(1)},b^{(2)},\\ldots,b^{(r)}$, and $W$ represents the $r$-component vector of Wiener processes, then\n\\[dZ=a(Z,t)dt+B(Z,t)dW.\\tag{6.16}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.strictVectorSDE",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整状态及时间依赖矩阵B(Z,t)，每坐标真实严格Ito积分与漂移；没有缩成常矩阵加性特例。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def strictVectorSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → ℝ → (Fin n → ℝ))
    (B : (Fin n → ℝ) → ℝ → Matrix (Fin n) (Fin r) ℝ) (x0 : Fin n → ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s i) volume 0 T) ∧
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ B (X s sample) s i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, X T sample i-x0 i-(∫ s in 0..T, a (X s sample) s i)=∑ j, integrals j sample)
```

### MD-6.3-BiasedWalkDiffusion
```json
{
  "source_id": "MD-6.3-BiasedWalkDiffusion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3",
  "printed_page": "232",
  "pdf_page": "253",
  "statement_latex": "Take the diffusion limit $\\delta t\\to0$, $\\delta x^2/\\delta t\\to1$ with $\\nu\\delta t=t$ fixed, then we obtain, under the Itô convention,\n\\[X(t)-X(0)=\\int_0^t a(X(s),s)ds+\\int_0^t b(X(s),s)dW(s).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.biasedWalkDiffusion",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确全局Lipschitz技术资格及AE连续W版本；完整SDE解存在与真实偏置有限游走线性插值的路径空间弱极限，没有只以定义取代扩散极限。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem biasedWalkDiffusion : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (W : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 T : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J →
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ W t sample) (Ici 0)) →
  (∃ L : ℝ≥0, LipschitzWith L (Function.uncurry a) ∧ LipschitzWith L (Function.uncurry b)) → 0 < T →
  ∃ X : ℝ → Ω → ℝ, strictScalarSDE P W X a b x0 ∧
    ∃ paths : Ω → C(Icc 0 T, ℝ),
      (∀ᵐ sample ∂P, ∀ t : Icc 0 T, paths sample t=X t sample) ∧
      ∃ walks : ℕ → Ω → C(Icc 0 T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample (t : Icc 0 T),
          walks K sample t = let dt := T/K; let k := Nat.floor ((t : ℝ)/dt);
            MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample +
            ((t : ℝ)-k*dt)/dt*(MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 (k+1) sample-
              MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample)) ∧
        (∀ F : C(Icc 0 T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
          Tendsto (fun K ↦ ∫ sample, F (walks K sample) ∂P) atTop (𝓝 (∫ sample, F (paths sample) ∂P)))
```

