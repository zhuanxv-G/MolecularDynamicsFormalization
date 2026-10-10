# BATCH11 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.2.4-FirstIntegral
```json
{
  "source_id": "MD-2.2.4-FirstIntegral",
  "kind": "definition",
  "label": null,
  "section": "2.2.4",
  "printed_page": "70",
  "pdf_page": "92",
  "statement_latex": "Recall that the condition for a given function $I:\\mathbb R^m\\to\\mathbb R$ to be a first integral is that\n\\[\\nabla I(\\boldsymbol z)\\cdot f(\\boldsymbol z)=\\sum_{j=1}^m\\frac{\\partial I}{\\partial z_j}(\\boldsymbol z)f_j(\\boldsymbol z)=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "条件在整个开放域D处处成立；I实际可微，f为给定向量场。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_firstIntegral",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-055"
  ]
}
```
```lean
def bp_firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0
```

### MD-2.2.4-IntegralPreserved
```json
{
  "source_id": "MD-2.2.4-IntegralPreserved",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.4",
  "printed_page": "70",
  "pdf_page": "92",
  "statement_latex": "It is important in this definition that this is an equivalence that holds everywhere (or at least in some open set in $\\mathbb R^m$), so the statement is not just that $I(\\boldsymbol z(t))=I(\\boldsymbol z(0))$ for some particular trajectory, but, moreover, $I$ is conserved for all nearby initial conditions. The flow map preserves the first integral, thus $I(\\mathcal F_t(\\boldsymbol z))=I(\\boldsymbol z)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.firstIntegralPreserved",
  "reusable_proofs": [],
  "extra_assumptions": [
    "开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-056"
  ]
}
```
```lean
theorem firstIntegralPreserved :
  ∀ n (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) (γ : ℝ → Q n) a b,
    a ≤ b → DifferentiableOn ℝ I D → IsOpen D → firstIntegral I f D →
    MapsTo γ (Icc a b) D → solution f γ a b → ∀ t ∈ Icc a b, I (γ t) = I (γ a)
```

### MD-2.2.4-EnergyPreserved
```json
{
  "source_id": "MD-2.2.4-EnergyPreserved",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.4",
  "printed_page": "70",
  "pdf_page": "92",
  "statement_latex": "For example, in a Hamiltonian system, the flow map conserves the energy:\n\\[H\\circ\\mathcal F_t=H.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.energyPreserved",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonian_energy_const_on_Icc"
  ],
  "extra_assumptions": [
    "实际Hamilton轨迹，H在轨道点可微，闭时间窗；现有第3章库仅作已证依赖复用，不开展第3章任务。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-057"
  ]
}
```
```lean
theorem energyPreserved (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0)
```

### MD-2.2.4-AngularMomentum
```json
{
  "source_id": "MD-2.2.4-AngularMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.4",
  "printed_page": "71",
  "pdf_page": "93",
  "statement_latex": "There may, in specific instances, be additional first integrals present. For example, in a planar 2-body system in central forces, the angular momentum $xp_y-yp_x=l$ is a conserved quantity, thus $l\\circ\\mathcal F_t=l$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.centralAngularMomentum",
  "reusable_proofs": [],
  "extra_assumptions": [
    "中心力写ρ(x²+y²)(x,y)，单位约化质量、实际ODE轨迹，a<b；正质量模型可缩放。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-058"
  ]
}
```
```lean
theorem centralAngularMomentum :
  ∀ (ρ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ × ℝ × ℝ) a b,
    a < b → (∀ t ∈ Icc a b, HasDerivWithinAt γ
      ((γ t).2.2.1,(γ t).2.2.2,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).1,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).2.1) (Icc a b) t) →
    ∀ t ∈ Icc a b, (γ t).1*(γ t).2.2.2-(γ t).2.1*(γ t).2.2.1 =
      (γ a).1*(γ a).2.2.2-(γ a).2.1*(γ a).2.2.1
```

### MD-2.2.4-IntegralMeanValue
```json
{
  "source_id": "MD-2.2.4-IntegralMeanValue",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.4",
  "printed_page": "71",
  "pdf_page": "93",
  "statement_latex": "Now if $I:\\mathbb R^m\\to\\mathbb R$ has continuous partial derivatives, we may conclude directly that\n\\[I(\\boldsymbol a)=I(\\boldsymbol b)+\\nabla I(\\boldsymbol z_*)\\cdot(\\boldsymbol a-\\boldsymbol b),\\]\nwhere $\\boldsymbol z_*$ is a point on the line in $\\mathbb R^m$ connecting $\\boldsymbol a$ to $\\boldsymbol b$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.integralMeanValue",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-059"
  ]
}
```
```lean
theorem integralMeanValue :
  ∀ n (I : EuclideanSpace ℝ (Fin n) → ℝ) (D : Set (EuclideanSpace ℝ (Fin n))) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b = (fderiv ℝ I c) (a-b)
```

### MD-2.2.4-IntegralLipschitz
```json
{
  "source_id": "MD-2.2.4-IntegralLipschitz",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.4",
  "printed_page": "71",
  "pdf_page": "93",
  "statement_latex": "Hence\n\\[|I(\\boldsymbol a)-I(\\boldsymbol b)|\\le\\|\\nabla I(\\boldsymbol z_*)\\|\\|\\boldsymbol a-\\boldsymbol b\\|.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "后句假设∇I在包含解的开放域中有界B；该签名登记统一B版本，点态z*结论由前项承担。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.integralPointwiseBound",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-060"
  ]
}
```
```lean
theorem integralPointwiseBound : ∀ n (I : EuclideanSpace ℝ (Fin n) → ℝ) (D : Set (EuclideanSpace ℝ (Fin n))) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b=(fderiv ℝ I c) (a-b) ∧
      |I a-I b| ≤ ‖fderiv ℝ I c‖*‖a-b‖
```

### MD-2.2.4-IntegralErrorPrinted
```json
{
  "source_id": "MD-2.2.4-IntegralErrorPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.4",
  "printed_page": "71",
  "pdf_page": "93",
  "statement_latex": "This means if we know that $\\|\\nabla I(\\boldsymbol z)\\|$ remains bounded, say less than $B$, in an open domain containing the solution, we could conclude that the error in $I$-values computed along a numerical trajectory is of order $h^p$,\n\\[|I(\\boldsymbol z(t_n))-I(\\boldsymbol z_n)|\\le\\frac{\\bar K B}{2L}e^{nLh}h^p,\\qquad h<\\bar h,\\tag{2.16}\\]\nwith the same assumptions as are needed to characterize the convergence of the method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "由(2.12)及均值不等式只能得Kbar B/L，额外1/2未推导；常数Kbar若重命名需明确。"
    }
  ],
  "lean_decl": "MD.Ch02.integralErrorPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "域含连接线段，B,K≥0及L>0；用原文先前轨迹误差界，不把待证积分误差作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "old_ids": [
    "CH02-061"
  ]
}
```
```lean
theorem integralErrorPrinted :
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/(2*L))*Real.exp (L*k*h)*h^p
```

