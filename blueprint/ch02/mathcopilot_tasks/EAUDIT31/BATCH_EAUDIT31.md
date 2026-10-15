# EAUDIT31：第2章§2.2.3网站修复复审

## 原文JSON
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
    "正文存在常数K≥0、Δ>0，式(2.10)使用\\bar K；疑似记号不一致，原文未在本处明确K=\\bar K，不静默修正。",
    "δ对应原文Δ；h>0来自PDF88本节起点；一致性阶要求p>0（PDF89）。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.consistency",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 显式0<p；本条只登记正自然数阶，属于[EXTRA]整数阶限制；保持统一K、δ及严格0<h<δ，不静默扩大端点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:08:20.565003",
      "before_sha256": "03fc6a3cbe82b1675ccada0daff93d270dbe8c603215b5ae095e654f95bebf73",
      "after_sha256": "3b8421931d792be9cb60af178210d39a5d97cba522d1fabc569e2c7d4c19d76c",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def consistency {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  0 < p ∧ ∃ K ≥ 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t)-G h (γ t)‖ ≤ K*h^(p+1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch02.consistency
```lean
def consistency {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  0 < p ∧ ∃ K ≥ 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t)-G h (γ t)‖ ≤ K*h^(p+1)
```

## 原文JSON
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
  "context_notation": [
    "式(2.12)中Kbar是局部误差界常数；正文K与式(2.10)的Kbar存在原书记号不一致。",
    "原文前提(2.10)只保证h<Δ，而此处结句写h≤Δ；端点需额外论证或假设，不静默修正。",
    "原式分母L需要L>0；已有非负稳定常数可放大为正数。固定L=0时应另用ε_n≤n Kbar h^{p+1}。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.errorBound",
  "reusable_proofs": [
    "MolecularDynamics.oneStep_error_bound"
  ],
  "extra_assumptions": [
    "h>0、L>0及K≥0显式化；L=0时可增大为正L，除零界不能字面使用；假设精确与数值留域来自原文。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:08:20.565003",
      "before_sha256": "f5523de91a933b9651a81279f21746213e7e9d8ff1559c1153b92a43c1734bf5",
      "after_sha256": "0a1a7408f9d7681bc5a9fc378860b013552b9ac1833290222b7a8dce66df4d85",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem errorBound (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p := by
  apply MolecularDynamics.oneStep_error_bound <;> assumption
```
### 实际依赖 MolecularDynamics.oneStepIterate
```lean
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _
```

## 原文JSON
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
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:08:20.565003",
      "before_sha256": "8717bc2d1e72b8d4185762b4913dc734969320aa7fb5d5a94950609ba76bf517",
      "after_sha256": "5239cec349f8fdf67dda16b9037eb075e6b3e5974f984260071c2738f66681be",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem verletExpansion :
  ∀ (F : ℝ → ℝ) q p, ContDiff ℝ 3 F →
    Asymptotics.IsBigO (𝓝 0)
      (fun h => (scalarVerlet F h (q,p)).2 -
        (p+h*F q+h^2/2*p*deriv F q+h^3/4*(deriv F q*F q+p^2*deriv (deriv F) q)))
      (fun h : ℝ => h^4) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.scalarVerlet
```lean
def scalarVerlet (F : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2+h^2/2*F z.1
  (q, z.2+h/2*(F z.1+F q))
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.3-ExactExpansion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.3",
  "printed_page": "68",
  "pdf_page": "90",
  "statement_latex": "Since $\\dot q=p$, we have $\\ddot q=\\dot p=F(q)$, and the third derivative is $q^{(3)}=F'(q)p$. On the other hand $\\dot p=F(q)$ implies that $\\ddot p=F'(q)\\dot q=pF'$, and thus\n\\[p^{(3)}=p^2F''+F'F.\\]\nThe Taylor expansion of the solution is (taking $q(t)=q$, $p(t)=p$):\n\\[q(t+h)=q+hp+\\frac{h^2}{2}F+\\frac{h^3}{6}F'p+O(h^4),\\]\n\\[p(t+h)=p+hF+\\frac{h^2}{2}pF'+\\frac{h^3}{6}[p^2F''+F'F]+O(h^4).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Example 2.2 的背景为单自由度 $q,p\\in\\mathbb R$、$M=1$，印刷p.67/PDF89。",
    "$F,F\\prime,F\\prime\\prime$ 在展开式中分别表示 $F(q),F\\prime(q),F\\prime\\prime(q)$；$q=q(t),p=p(t)$ 为展开起点；印刷p.68/PDF90。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.exactExpansion",
  "reusable_proofs": [],
  "extra_assumptions": [
    "F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:08:20.565003",
      "before_sha256": "d8ac1a2efed04e6f7d9f996e09461de9dea5952bf90f291eace5ceeafcc02d3a",
      "after_sha256": "ce7ac0b6994b5dec5349fb3081b2e32c5dc41b4665a8f3ba54433ed1f05e93d5",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem exactExpansion :
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).1 -
      ((γ 0).1+h*(γ 0).2+h^2/2*F (γ 0).1+h^3/6*deriv F (γ 0).1*(γ 0).2)) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).2 -
      ((γ 0).2+h*F (γ 0).1+h^2/2*(γ 0).2*deriv F (γ 0).1+
        h^3/6*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))) (fun h : ℝ => h^4) := by
  sorry
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.3-VerletConsistency",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.3",
  "printed_page": "68",
  "pdf_page": "90",
  "statement_latex": "These relations can be summarized as telling us that\n\\[\\|\\mathcal G_h(\\boldsymbol z)-\\mathcal F_h(\\boldsymbol z)\\|=\\kappa(\\boldsymbol z)h^3+O(h^4),\\]\nwhere $\\kappa(\\boldsymbol z)=\\kappa(q,p)$ is a function of the position and momentum. We may then define\n\\[\\bar K=\\max_{t\\in[0,\\tau]}\\kappa(\\boldsymbol z(t))\\]\nbounding the local error by (with neglect of the fourth order terms) $\\bar K h^3$. Thus the Verlet method is consistent of order two.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Example 2.2 的背景为单自由度 $q,p\\in\\mathbb R$、$M=1$，印刷p.67/PDF89。",
    "$F,F\\prime,F\\prime\\prime$ 在展开式中分别表示 $F(q),F\\prime(q),F\\prime\\prime(q)$；$q=q(t),p=p(t)$ 为展开起点；印刷p.68/PDF90。",
    "数值输出为 $(Q,P)$：$Q=q+hp+h^2F(q)/2$，$P=p+h(F(q)+F(Q))/2$，式(2.13)–(2.14)，印刷p.67/PDF89。",
    "$\\boldsymbol z=(q,p)$；$\\mathcal G_h$ 是 Verlet 单步映射，$\\mathcal F_h$ 是精确解单步映射；误差范数及一致性阶数的说明见印刷p.67/PDF89；$\\tau$ 为考察的时间区间终点，$\\bar K$ 是该轨迹上 $\\kappa$ 的最大值，印刷p.68/PDF90。"
  ],
  "issues": [
    {
      "code": "NEGLECTED_REMAINDER",
      "status": "NEEDS_HUMAN",
      "detail": "原文忽略O(h⁴)后用maxκ界误差，不是严格界；保留κ主项和严格一致性，常数区分maxκ与吸收余项后的C。"
    }
  ],
  "lean_decl": "MD.Ch02.verletConsistency",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际标量M=1流、F C³、正时间窗和连续紧轨迹；O余项在h→0+解释；严格界C允许吸收余项，不宣称C=maxκ。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:08:20.565003",
      "before_sha256": "3971dfbe4ffe6f0e2750936a3a879f884b4b777422de58041537fa13bdfbc6d3",
      "after_sha256": "b2249027e0dc516bf1a24bdc366ba9a980cd3d36202cf174c27d4ddbdcd04d83",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem verletConsistency : ∀ (F : ℝ → ℝ) (Φ : ℝ → (ℝ × ℝ) → (ℝ × ℝ))
    (γ : ℝ → ℝ × ℝ) τ δ,
    0 < τ → 0 < δ → ContDiff ℝ 3 F → ContinuousOn γ (Icc 0 τ) →
    (∀ z, Φ 0 z=z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun s => Φ s z) ((Φ t z).2,F (Φ t z).1) t) →
    (∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ, γ (t+h)=Φ h (γ t)) →
    ∃ κ : ℝ × ℝ → ℝ, ContinuousOn κ (Set.range γ) ∧
      (∀ z ∈ Set.range γ, 0 ≤ κ z ∧ Asymptotics.IsBigO (𝓝[>] 0)
        (fun h => ‖scalarVerlet F h z-Φ h z‖-κ z*h^3) (fun h : ℝ => h^4)) ∧
      (∃ K ≥ 0, (∀ t ∈ Icc 0 τ, κ (γ t) ≤ K) ∧
        (∃ t ∈ Icc 0 τ, κ (γ t)=K)) ∧
      (∃ C ≥ 0, ∃ δ₀ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ₀,
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.scalarVerlet
```lean
def scalarVerlet (F : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2+h^2/2*F z.1
  (q, z.2+h/2*(F z.1+F q))
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.3-VerletStability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.3",
  "printed_page": "68–69",
  "pdf_page": "90–91",
  "statement_latex": "To complete the convergence proof for Verlet’s method, we would still need to verify the second assumption. This requires the assumption that the force field $F$ satisfy a Lipschitz condition:\n\\[\\|F(\\boldsymbol u)-F(\\boldsymbol w)\\|\\le\\hat L\\|\\boldsymbol u-\\boldsymbol w\\|\\tag{2.15}\\]\nfor all $\\boldsymbol u,\\boldsymbol w$. Generally speaking this could be taken to hold in a neighborhood of the solution where all approximate solutions for $h<\\bar h$ are assumed to lie. With a bit of effort, it is then possible to demonstrate the stability condition for the numerical method (see Exercise 4).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\boldsymbol u,\\boldsymbol w$ 为力的输入位置；$\\hat L$ 为 Lipschitz 常数，式(2.15)，印刷p.68/PDF90。",
    "稳定性指每一步两条附近轨迹间距离至多增大因子 $1+hL$，印刷p.67/PDF89；$\\bar h$ 是所有近似解仍在所述邻域内的步长阈值，印刷p.69/PDF91。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.verletStability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:08:20.565003",
      "before_sha256": "8fe597a81237b48a9efeef0ac104ae052d4cf21d55b42cfc476bf74a913cf7cd",
      "after_sha256": "b8abdf178c30c30fa35c3c0433931d95cfd4d06a679634f9638785733fb138c7",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem verletStability :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) L δ,
    positiveMass m → 0 ≤ L → 0 < δ →
    (∀ u w, ‖F u-F w‖ ≤ L*‖u-w‖) →
    ∃ C ≥ 0, ∀ h ∈ Icc 0 δ, ∀ z w : Z n,
      ‖verlet m F h z-verlet m F h w‖ ≤ (1+h*C)*‖z-w‖ := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.positiveMass
```lean
def positiveMass {n : ℕ} (m : Fin n → ℝ) : Prop := ∀ i, 0 < m i
```
### 实际依赖 MolecularDynamics.Chapter02Review.verlet
```lean
def verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
```
