# BATCH09 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.2.3-HamiltonianDivergence
```json
{
  "source_id": "MD-5.2.3-HamiltonianDivergence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.3",
  "printed_page": "186",
  "pdf_page": "207",
  "statement_latex": "The term $\\nabla\\cdot f$ vanishes for $f=J\\nabla H$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.hamiltonianDivergence",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianVectorField_divergence_zero"
  ],
  "extra_assumptions": [
    "[EXTRA]固定正式库的实际规范坐标、Jacobian及C² Hamiltonian；保留任意H，既有证明由真实Hessian对称性推出散度零。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianDivergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0
```

### MD-5.2.3-HamiltonianSkewExpression
```json
{
  "source_id": "MD-5.2.3-HamiltonianSkewExpression",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.3",
  "printed_page": "186",
  "pdf_page": "207",
  "statement_latex": "From the above we know that for a smooth scalar function $u=u(z)$, $\\mathcal L_f^*u=-\\nabla\\cdot(uf)=-f\\cdot\\nabla u-u\\nabla\\cdot f$. The term $\\nabla\\cdot f$ vanishes for $f=J\\nabla H$. Thus we have $\\mathcal L_f^*u=-f\\cdot\\nabla u=-\\mathcal L_fu$. If this holds for all smooth $u$, we write $\\mathcal L_f^*=-\\mathcal L_f$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.hamiltonianSkewExpression",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianSkewExpression :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ),
  Differentiable ℝ f → Differentiable ℝ u → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  ∀ z,MolecularDynamics.Chapter05Review.liouvillian f u z= -MolecularDynamics.Chapter05Review.lie f u z
```

### MD-5.2.3-HamiltonianDensityPropagation
```json
{
  "source_id": "MD-5.2.3-HamiltonianDensityPropagation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.3",
  "printed_page": "187",
  "pdf_page": "208",
  "statement_latex": "An important consequence of the skew symmetry of $\\mathcal L_f$ for a divergence-free system is that the propagator $e^{t\\mathcal L_f^*}$ preserves the integral over the whole phase space, i.e.\n\\[\\int_D e^{t\\mathcal L_f^*}\\rho(z)d\\omega=\\int_D e^{-t\\mathcal L_f}\\rho(z)d\\omega=\\int_D\\rho(\\mathcal F_{-t}(z))d\\omega=\\int_D\\rho(z)d\\omega,\\]\nsince we can view $\\mathcal F_{-t}(z)$ as a change of variables by a volume-preserving map.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.hamiltonianDensityPropagation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianDensityPropagation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  (∀ t,Φ t '' D=D) → densityOn D ρ → ∀ t,
    (∫ z in D,ρ (Φ (-t) z))=(∫ z in D,ρ z) ∧
    densityMeasureOn D (fun z => ρ (Φ (-t) z))=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D ρ)
```

### MD-5.2.3-MechanicalLiouvillian
```json
{
  "source_id": "MD-5.2.3-MechanicalLiouvillian",
  "kind": "definition",
  "label": null,
  "section": "5.2.3",
  "printed_page": "187",
  "pdf_page": "208",
  "statement_latex": "The Liouvillian of a Hamiltonian system with $N_c$ degrees of freedom and a Hamiltonian of the form $H=\\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\\ldots,q_{N_c})$ can be written\n\\[\\mathcal L_H^*=-\\sum_{i=1}^{N_c}m_i^{-1}p_i\\frac{\\partial}{\\partial q_i}-\\sum_{i=1}^{N_c}F_i\\frac{\\partial}{\\partial p_i},\\]\nwhere $F_i=-\\partial U/\\partial q_i$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际相空间Fréchet导数沿(p/m,F)方向的负值，是上述坐标偏导求和；完整原H触发到该表达式的对应另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.mechanicalLiouvillian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (u : MolecularDynamics.Chapter05Review.Phase n → ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
```

### MD-5.2.3-MechanicalLiouvillianIdentity
```json
{
  "source_id": "MD-5.2.3-MechanicalLiouvillianIdentity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.3",
  "printed_page": "187",
  "pdf_page": "208",
  "statement_latex": "The Liouvillian of a Hamiltonian system with $N_c$ degrees of freedom and a Hamiltonian of the form $H=\\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\\ldots,q_{N_c})$ can be written $\\mathcal L_H^*=-\\sum_i m_i^{-1}p_i\\partial_{q_i}-\\sum_iF_i\\partial_{p_i}$, where $F_i=-\\partial U/\\partial q_i$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.mechanicalLiouvillianIdentity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem mechanicalLiouvillianIdentity : ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ i,0 < m i) → ContDiff ℝ 2 U →
  ∀ (u : MolecularDynamics.Chapter05Review.Phase n → ℝ),Differentiable ℝ u → ∀ z,
    -(fderiv ℝ u z) (MolecularDynamics.Chapter05Review.hamiltonianField
      (fun x => (∑ i,(x.2 i)^2/(2*m i))+U x.1) z)=
    MolecularDynamics.Chapter05Review.mechanicalLiouvillian m (fun q => -gradient U q) u z
```

