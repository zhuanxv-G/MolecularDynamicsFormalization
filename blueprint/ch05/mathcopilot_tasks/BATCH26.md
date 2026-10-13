# BATCH26 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.6-VerletShadow2
```json
{
  "source_id": "MD-5.6-VerletShadow2",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "208",
  "pdf_page": "229",
  "statement_latex": "For the Verlet scheme the modified Hamiltonian is\n\\[\\widetilde H_h=H+\\frac{h^2}{24}\\left(2p^TM^{-1}U''(q)M^{-1}p-\\nabla U(q)M^{-1}\\nabla U(q)\\right)+O(h^4).\\]\nActually, as explained previously, we must interpret this carefully: a finite truncation of this expansion may characterize the discrete trajectories observed in practice, but the series expansion itself does not typically converge.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实一般U的Hessian沿v=M⁻¹p作用和力平方项；定义有限h²截断，O(h⁴)和全阶展开不作为已证的精确能量保持。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.verletShadow2",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def verletShadow2 {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ) (h : ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  let v : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 fun i => z.2 i/m i
  (∑ i,z.2 i^2/m i)/2+U z.1+h^2/24*
    (2*(fderiv ℝ (fderiv ℝ U) z.1) v v-∑ i,(MolecularDynamics.Chapter05Review.grad U z.1 i)^2/m i)
```

### MD-5.6-Theorem51
```json
{
  "source_id": "MD-5.6-Theorem51",
  "kind": "theorem",
  "label": "Theorem 5.1",
  "section": "5.6",
  "printed_page": "208–209",
  "pdf_page": "229–230",
  "statement_latex": "Theorem 5.1 Let $H(q,p)$ and $\\widetilde H(q,p)=H(q,p)+\\varepsilon\\eta(q,p)$ be two Hamiltonian functions. Suppose the energy surface $\\Sigma_E=\\{(q,p)\\mid H(q,p)=E\\}$ to be compact and define the perturbed energy surface by $\\widetilde\\Sigma_E=\\{(q,p)\\mid\\widetilde H(q,p)=E\\}$, also assumed compact.\nSuppose that $w$ is an arbitrary smooth vector field such that $w\\cdot\\nabla H\\ne0$ on $\\Sigma_E$. Then the perturbation of the microcanonical average of a smooth function $g$ is given by\n\\[\\operatorname{Av}_{H=E}(g)-\\operatorname{Av}_{\\widetilde H=E}(g)=\\operatorname{Av}_{\\widetilde H=E}(\\nabla\\cdot gu)-\\operatorname{Av}_{\\widetilde H=E}(g)\\operatorname{Av}_{\\widetilde H=E}(\\nabla\\cdot u)+O(\\varepsilon^2),\\]\nwhere $u=\\varepsilon\\eta w/(w\\cdot\\nabla H)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.theorem51",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际C∞和regularEnergy含梯度非零及raw总质量有限正；补统一紧能量带与其上分母不为零，量化完整O(ε²)平均差。不只陈述分母下界，不将校正关系作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem theorem51 :
  ∀ n (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c,
    0 < n → ContDiff ℝ ⊤ H → ContDiff ℝ ⊤ η → ContDiff ℝ ⊤ g → ContDiff ℝ ⊤ w →
    MolecularDynamics.Chapter05Review.regularEnergy H c → (∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) →
    (∃ δ > 0, ∃ K : Set (MolecularDynamics.Chapter05Review.E n), IsCompact K ∧
      ∀ ε ∈ Ioo (-δ) δ, MolecularDynamics.Chapter05Review.regularEnergy (fun z => H z+ε*η z) c ∧
        MolecularDynamics.Chapter05Review.energySurface (fun z => H z+ε*η z) c ⊆ K ∧
        (∀ z ∈ K,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0)) →
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |MolecularDynamics.Chapter05Review.microAverage H c g-MolecularDynamics.Chapter05Review.microAverage (fun z => H z+ε*η z) c g-
        MolecularDynamics.Chapter05Review.perturbationCorrection H η g w c ε| ≤ C*ε^2
```

### MD-5.6-PerturbationDisplacement
```json
{
  "source_id": "MD-5.6-PerturbationDisplacement",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "209",
  "pdf_page": "230",
  "statement_latex": "$u=\\varepsilon\\frac{\\eta}{w\\cdot\\nabla H}w$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实向量场与Euclidean内积；分母在相关带内非零资格另列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.perturbationDisplacement",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def perturbationDisplacement {n : ℕ} (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  (ε*η z/inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)) • w z
```

### MD-5.6-PerturbationCorrection
```json
{
  "source_id": "MD-5.6-PerturbationCorrection",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "209",
  "pdf_page": "230",
  "statement_latex": "$\\operatorname{Av}_{H=E}(g)-\\operatorname{Av}_{\\widetilde H=E}(g)=\\operatorname{Av}_{\\widetilde H=E}(\\nabla\\cdot gu)-\\operatorname{Av}_{\\widetilde H=E}(g)\\operatorname{Av}_{\\widetilde H=E}(\\nabla\\cdot u)+O(\\varepsilon^2)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际div(g u)，保留g·div u项；不是仅grad g·u。定义校正函数不等于完整Theorem5.1已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.perturbationCorrection",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def perturbationCorrection {n : ℕ} (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := MolecularDynamics.Chapter05Review.perturbationDisplacement H η w ε
  MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence (fun z => g z • u z))-
    MolecularDynamics.Chapter05Review.microAverage Hε c g*MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence u)
```

### MD-5.6-DenominatorBound
```json
{
  "source_id": "MD-5.6-DenominatorBound",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "209",
  "pdf_page": "230",
  "statement_latex": "Suppose that $w$ is an arbitrary smooth vector field such that $w\\cdot\\nabla H\\ne0$ on $\\Sigma_E$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.denominatorBound",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.denominatorBound_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]单独保留紧集上实际连续绝对分母的正下界，是完整定理的基础后果，不替代完整校正关系。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem denominatorBound {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c
    (hK : IsCompact (MolecularDynamics.Chapter05Review.energySurface H c))
    (hc : ContinuousOn (fun z => |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)|) (MolecularDynamics.Chapter05Review.energySurface H c))
    (hn : ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,a ≤ |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)|
```

### MD-5.6-SmoothDenominatorBound
```json
{
  "source_id": "MD-5.6-SmoothDenominatorBound",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "209",
  "pdf_page": "230",
  "statement_latex": "Suppose that $w$ is an arbitrary smooth vector field such that $w\\cdot\\nabla H\\ne0$ on $\\Sigma_E$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.smoothDenominatorBound",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.smoothDenominatorBound_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]由C² H、连续w自动得到实际连续分母和紧性下界；正式已证特殊后果，不当完整微正则扰动定理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem smoothDenominatorBound {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c
    (hK : IsCompact (MolecularDynamics.Chapter05Review.energySurface H c)) (hH : ContDiff ℝ 2 H) (hw : Continuous w)
    (hn : ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,a ≤ |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)|
```

### MD-5.6-ZeroPerturbation
```json
{
  "source_id": "MD-5.6-ZeroPerturbation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "209",
  "pdf_page": "230",
  "statement_latex": "$\\widetilde H(q,p)=H(q,p)+\\varepsilon\\eta(q,p)$; $u=\\varepsilon\\eta w/(w\\cdot\\nabla H)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.zeroPerturbation",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.zeroPerturbation_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]η恒0时实际校正函数为0的直接后果；不将零扰动特例冒充任意η的平均误差定理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem zeroPerturbation {n : ℕ} (H g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c ε :
    MolecularDynamics.Chapter05Review.perturbationCorrection H (fun _ => 0) g w c ε=0
```

### MD-5.6-GradientTransverse
```json
{
  "source_id": "MD-5.6-GradientTransverse",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "209",
  "pdf_page": "230",
  "statement_latex": "A natural choice of the function $w$ that appears in the theorem is $w=\\nabla H$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.gradientTransverse",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正则能量面grad H非零，实际平方范数保证横截；不是任意能量处的无条件结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gradientTransverse :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  (∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
    ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (MolecularDynamics.Chapter05Review.grad H z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0
```

