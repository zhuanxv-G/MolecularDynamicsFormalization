# BATCH37 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.4-UnitLangevinModel
```json
{
  "source_id": "MD-6.4.4-UnitLangevinModel",
  "kind": "definition",
  "label": "(6.47)",
  "section": "6.4.4",
  "printed_page": "251",
  "pdf_page": "272",
  "statement_latex": "In Langevin dynamics, taking $M=I$ for simplicity,\n\\[dq=pdt;\\qquad dp=-\\nabla U(q)dt-\\gamma pdt+\\sqrt{2\\gamma k_BT}dW;\\tag{6.47}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.unitLangevinModel",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实单位质量完整耦合路径方程；β>0及光滑势保证原梯度存在，γ>0由实际MassLangevin资格保留。Wiener law在对应定理另给，不宣称任意W是Wiener。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def unitLangevinModel {n : ℕ} {A : Type*} [MeasurableSpace A] (P : Measure A)
    (W : ℝ → A → (Fin n → ℝ)) (X : ℝ → A → ((Fin n → ℝ) × (Fin n → ℝ)))
    (U : (Fin n → ℝ) → ℝ) (γ β : ℝ) (x0 : (Fin n → ℝ) × (Fin n → ℝ)) : Prop :=
  0 < β ∧ ContDiff ℝ ∞ U ∧ MD.Ch06.langevinMassSDE P W X (fun _ ↦ 1) U γ β⁻¹ x0
```

### MD-6.4.4-PeriodicConfiningPrinted
```json
{
  "source_id": "MD-6.4.4-PeriodicConfiningPrinted",
  "kind": "definition",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253",
  "pdf_page": "274",
  "statement_latex": "The whole phase space is $D=\\mathbb T^{N_c}\\times\\mathbb R^{N_c}$. We also consider the potential energy to be smooth ($C^\\infty$) with $U(q)\\to\\infty$ as $|q|\\to\\infty$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原周期位置域与同一势能lift的q→∞围束条件冲突；保留字面资格而非构造一个不存在的周期围束势。"
    }
  ],
  "lean_decl": "MD.Ch06.periodicConfiningPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际正维单位周期lift，cocompact表达配置无穷远；不是动量Hamiltonian的围束。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "围束对象改为环面×动量空间上的Hamiltonian幂；无穷远只涉及动量方向。",
      "corrected_decl": "MD.Ch06.periodicConfiningPrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def periodicConfiningPrinted {n : ℕ} (_hn : 0 < n) (U : (Fin n → ℝ) → ℝ) : Prop :=
  ContDiff ℝ ∞ U ∧ textbookUnitPeriodicPotential U ∧
    Tendsto U (cocompact (Fin n → ℝ)) atTop
```

### MD-6.4.4-HamiltonianPower
```json
{
  "source_id": "MD-6.4.4-HamiltonianPower",
  "kind": "definition",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253",
  "pdf_page": "274",
  "statement_latex": "For the Lyapunov condition (Assumption 2), we choose the Lyapunov function\n\\[\\varphi(q,p)=H^l(q,p)=\\left[\\tfrac12\\|p\\|^2+U(q)\\right]^l;\\]\nfor a fixed positive integer $l$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.hamiltonianPower",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]l≥1编码，真实单位质量Hamiltonian，未把形式jet当真实函数；正性与柱形proper在后续实际桥接证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def hamiltonianPower {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (_hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) : ℝ := textbookLangevinHamiltonian U z ^ l
```

### MD-6.4.4-HamiltonianPowerCancellation
```json
{
  "source_id": "MD-6.4.4-HamiltonianPowerCancellation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253",
  "pdf_page": "274",
  "statement_latex": "we can see that\n\\[p\\cdot\\nabla_q\\varphi-\\nabla U(q)\\cdot\\nabla_p\\varphi=\\mathcal L_H\\varphi=0;\\]\nwhere $\\mathcal L_H$ is the Lie derivative of our original Hamiltonian system (which preserves all functions of the Hamiltonian).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.hamiltonianPowerCancellation",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinHamiltonianPower_drift_hasDerivAt"
  ],
  "extra_assumptions": [
    "[EXTRA]实际沿Hamiltonian方向的真实导数为0；γ=0只在此Hamiltonian部分，非把整个物理Langevin摩擦设零。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianPowerCancellation {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : Differentiable ℝ U) (l : ℕ) (_hl : 1 ≤ l) (z : textbookLangevinPhase n) :
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
    (z+t • textbookLangevinDrift U 0 z)) 0 0
```

### MD-6.4.4-HamiltonianPowerMomentumDerivative
```json
{
  "source_id": "MD-6.4.4-HamiltonianPowerMomentumDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253",
  "pdf_page": "274",
  "statement_latex": "Using $\\|p\\|^2<2H$, we compute derivatives to find\n\\[p\\cdot\\nabla_p\\varphi=lH^{l-1}\\|p\\|^2=2l\\varphi-2lH^{l-1}U(q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.hamiltonianPowerMomentumDerivative",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实沿动量p方向的导数及全部两个表达式，不仅登记事先给定的导数值；实际所有坐标平方和。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianPowerMomentumDerivative : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (l : ℕ) (z : textbookLangevinPhase n), 1 ≤ l →
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l (z.1,(1+t) • z.2))
    ((l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2)) 0 ∧
  (l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2) =
    2*(l : ℝ)*textbookLangevinHamiltonianPower U l z -
      2*(l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*U z.1
```

### MD-6.4.4-HamiltonianPowerMomentumLaplacian
```json
{
  "source_id": "MD-6.4.4-HamiltonianPowerMomentumLaplacian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253",
  "pdf_page": "274",
  "statement_latex": "\\[\\Delta_p\\varphi=l(l-1)H^{l-2}\\|p\\|^2+N_clH^{l-1}\\le l(l+N_c-1)H^{l-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.hamiltonianPowerMomentumLaplacian",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian"
  ],
  "extra_assumptions": [
    "[EXTRA]完整实际坐标二阶导数和及正确等式，l≥1；原随后不等式单独原样保存，未据等式声称它成立。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianPowerMomentumLaplacian {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (hl : 1 ≤ l) (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) =
      (l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) * (∑ i, z.2 i ^ 2) +
        (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1)
```

### MD-6.4.4-LaplacianBoundPrinted
```json
{
  "source_id": "MD-6.4.4-LaplacianBoundPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253",
  "pdf_page": "274",
  "statement_latex": "\\[\\Delta_p\\varphi=l(l-1)H^{l-2}\\|p\\|^2+N_clH^{l-1}\\le l(l+N_c-1)H^{l-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "用|p|²≤2H推导时遗漏系数2；一般原界不成立，具体52>40反例另给。"
    }
  ],
  "lean_decl": "MD.Ch06.laplacianBoundPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "系数l(l+Nc−1)改为2l(l−1)+Nc·l。",
      "corrected_decl": "MD.Ch06.laplacianBoundPrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem laplacianBoundPrinted : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ),
  (∀ q, 1 ≤ U q) → ∀ (l : ℕ), 1 ≤ l → ∀ z : textbookLangevinPhase n,
    (∑ i : Fin n, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z+t • ((0 : Fin n → ℝ), Pi.single i 1)))) 0) ≤
      (l : ℝ)*((l : ℝ)+(n : ℝ)-1)*textbookLangevinHamiltonian U z^(l-1)
```

### MD-6.4.4-LaplacianBoundCounterexample
```json
{
  "source_id": "MD-6.4.4-LaplacianBoundCounterexample",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253",
  "pdf_page": "274",
  "statement_latex": "\\[\\Delta_p\\varphi=l(l-1)H^{l-2}\\|p\\|^2+N_clH^{l-1}\\le l(l+N_c-1)H^{l-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.laplacianBoundCounterexample",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinLyapunov_printed_laplacian_bound_counterexample"
  ],
  "extra_assumptions": [
    "[EXTRA]现成具体n=1、U=2、l=2、p=4反例52>40；仅差异证据，未用它替代原全量词界或完整Lyapunov论证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem laplacianBoundCounterexample :
    deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 = 52 ∧
      ¬ deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 ≤
        (2 : ℝ) * (2 + 1 - 1) * (4 ^ 2 / 2 + 2) ^ (2 - 1 : ℕ)
```

