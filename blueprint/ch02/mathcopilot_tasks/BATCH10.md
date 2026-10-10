# BATCH10 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.2.3-ExactExpansion
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
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.exactExpansion",
  "reusable_proofs": [],
  "extra_assumptions": [
    "F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem exactExpansion :
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).1 -
      ((γ 0).1+h*(γ 0).2+h^2/2*F (γ 0).1+h^3/6*deriv F (γ 0).1*(γ 0).2)) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).2 -
      ((γ 0).2+h*F (γ 0).1+h^2/2*(γ 0).2*deriv F (γ 0).1+
        h^3/6*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))) (fun h : ℝ => h^4)
```

### MD-2.2.3-DefectPrinted
```json
{
  "source_id": "MD-2.2.3-DefectPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.3",
  "printed_page": "68",
  "pdf_page": "90",
  "statement_latex": "We now examine the series expansions for the exact and Verlet solutions and find that these differ in the third (and higher) order terms.\n\\[Q-q(t+h)=\\frac{h^3}{6}F'p+O(h^4),\\]\nand\n\\[P-p(t+h)=\\frac{h^3}{12}[p^2F''+F'F]+O(h^4).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "位置Q仅到h²，减精确q(t+h)应为负h³F′p/6；原页为正号，保留字面。"
    }
  ],
  "lean_decl": "MD.Ch02.defectPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际轨迹、F C³；t=0归一。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem defectPrinted : ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1-
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))
      (fun h : ℝ => h^4)
```

### MD-2.2.3-VerletConsistency
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
  "context_notation": [],
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
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
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
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3)
```

### MD-2.2.3-VerletStability
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
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.verletStability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem verletStability :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) L δ,
    positiveMass m → 0 ≤ L → 0 < δ →
    (∀ u w, ‖F u-F w‖ ≤ L*‖u-w‖) →
    ∃ C ≥ 0, ∀ h ∈ Icc 0 δ, ∀ z w : Z n,
      ‖verlet m F h z-verlet m F h w‖ ≤ (1+h*C)*‖z-w‖
```

