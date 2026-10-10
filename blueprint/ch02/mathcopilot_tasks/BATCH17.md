# BATCH17 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.3.4-Hessian
```json
{
  "source_id": "MD-2.3.4-Hessian",
  "kind": "definition",
  "label": null,
  "section": "2.3.4",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "where $S(t)=H_{zz}(\\boldsymbol z(t,\\boldsymbol\\zeta))$ is a symmetric matrix.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "S为沿实际轨迹取值的Hessian；对称结论另项保留。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_hessian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def bp_hessian {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc := fun i j =>
  fderiv ℝ (fderiv ℝ H) z (Pi.single i 1) (Pi.single j 1)
```

### MD-2.3.4-HessianSymmetry
```json
{
  "source_id": "MD-2.3.4-HessianSymmetry",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.4",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "where $S(t)=H_{zz}(\\boldsymbol z(t,\\boldsymbol\\zeta))$ is a symmetric matrix.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.hessianSymmetry",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianHessian_isSymm"
  ],
  "extra_assumptions": [
    "H在所取点C²，混合偏导相等。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hessianSymmetry {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) : (textbookHamiltonianHessian H z).IsSymm
```

### MD-2.3.4-HamiltonVariationalPrinted
```json
{
  "source_id": "MD-2.3.4-HamiltonVariationalPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.4",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "For the Hamiltonian system $\\dot{\\boldsymbol z}=J\\nabla H(\\boldsymbol z)$, these take the form:\n\\[\\dot W=JS(t)W,\\]\nwhere $S(t)=H_{zz}(\\boldsymbol z(t,\\boldsymbol\\zeta))$ is a symmetric matrix.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页后段W(t)=F′t(z(t,ζ))字面采用移动点；S=Hessian在轨迹点。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "与p.73一样W应在固定初值ζ求导；原页后文明确W(t)=F′t(z(t,ζ))，本条保留该字面W。"
    }
  ],
  "lean_decl": "MD.Ch02.hamiltonVariationalPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonVariationalPrinted : ∀ n (H : SymplecticCoordinates n → ℝ)
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ ζ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, HasDerivAt
      (fun s => textbookJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,ζ)) *
        textbookJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t
```

### MD-2.3.4-MatrixCancellation
```json
{
  "source_id": "MD-2.3.4-MatrixCancellation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.4",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "Computing\n\\[W^TJ\\dot W=W^TJ^2SW=-W^TSW,\\]\nwhereas\n\\[\\dot W^TJW=W^TS^TJ^TJW=W^TSW,\\]\nhence\n\\[\\frac{\\mathrm d}{\\mathrm dt}W^TJW=W^TJ\\dot W+\\dot W^TJW=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "W′=JSW由前项背景；本条矩阵恒等式两个乘积项之和为0，实际乘积求导见FormConstant。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.matrixCancellation",
  "reusable_proofs": [
    "MolecularDynamics.hamiltonian_variational_matrix_cancellation"
  ],
  "extra_assumptions": [
    "S对称；任意矩阵W。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem matrixCancellation {Nc : ℕ}
    (S W : SymplecticCoordinateMatrix Nc) (hS : S.IsSymm) :
    (textbookJ Nc * S * W)ᵀ * textbookJ Nc * W +
      Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) = 0
```

### MD-2.3.4-FormConstant
```json
{
  "source_id": "MD-2.3.4-FormConstant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.4",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "This means that $W^TJW$ is a constant matrix.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.formConstant",
  "reusable_proofs": [
    "MolecularDynamics.hamiltonian_variational_form_constant"
  ],
  "extra_assumptions": [
    "S(t)逐点对称，W实际满足W′=JSW，闭连通时间窗；这一独立矩阵ODE陈述不把流的变分方程结论作流辛性前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem formConstant {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (τ : ℝ)
    (hS : ∀ t ∈ Icc 0 τ, (S t).IsSymm)
    (hW : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt W (textbookJ Nc * S t * W t) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, (W t)ᵀ * textbookJ Nc * W t = (W 0)ᵀ * textbookJ Nc * W 0
```

### MD-2.3.4-HamiltonSymplectic
```json
{
  "source_id": "MD-2.3.4-HamiltonSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.4",
  "printed_page": "79",
  "pdf_page": "101",
  "statement_latex": "hence\n\\[W^TJW\\equiv W(0)^TJW(0)=J.\\]\nThis proves that the flow map of a Hamiltonian system is a symplectic map.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文W移动取值点疑点另项记录；本最终结论以实际固定时刻流映射的Jacobian表达，不假设其变分方程。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonSymplectic",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]实际解族联合C²；H C²、Φ0=id、τ>0及真实Hamilton ODE。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonSymplectic {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t, z))
```

