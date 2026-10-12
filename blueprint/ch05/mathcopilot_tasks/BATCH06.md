# BATCH06 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.2.2-MassFraction
```json
{
  "source_id": "MD-5.2.2-MassFraction",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "Let $\\rho(z;t)$ be the probability density associated to a collection of phase points moving under a vector field $f$ on the phase space $\\mathbb R^m$. Let $A$ be a suitable region of volume $V$ within the phase space (say a rectangular $m$-dimensional box). The fraction $\\vartheta$ of phase points present in $A$ at time $t$ is the integral of $\\rho$ over $A$:\n\\[\\vartheta(t)=\\int_A\\rho(z;t)\\,d\\omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际随时间变化的区域积分；不把轨道时间平均混作密度集合的质量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.massFraction",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def massFraction {n : ℕ} (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) := ∫ z in A,ρ t z
```

### MD-5.2.2-MassDerivative
```json
{
  "source_id": "MD-5.2.2-MassDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "which may be viewed as a smooth function of time. On the one hand\n\\[\\frac{d\\vartheta}{dt}=\\int_A\\frac{\\partial\\rho(z;t)}{\\partial t}\\,d\\omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.massDerivative",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确参数微分与积分交换所需的可积支配界、邻域逐点可微及可积性；不假设已交换的导数等式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem massDerivative :
  ∀ n (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) t,
  MeasurableSet A → (∀ s,IntegrableOn (ρ s) A) →
  (∃ δ > 0, ∃ b : MolecularDynamics.Chapter05Review.E n → ℝ, IntegrableOn b A ∧
    (∀ s ∈ Ioo (t-δ) (t+δ), ∀ z ∈ A, HasDerivAt (fun u => ρ u z) (deriv (fun u => ρ u z) s) s ∧
      |deriv (fun u => ρ u z) s| ≤ b z)) →
  HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A) (∫ z in A,deriv (fun u => ρ u z) t) t
```

### MD-5.2.2-OutwardNormal
```json
{
  "source_id": "MD-5.2.2-OutwardNormal",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "where $n(z)$ is the unit outward normal to the surface $\\partial A$ at the point $z$ and $d\\sigma$ is the surface element.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.outwardNormalFor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]通过局部真实光滑定义函数r的负侧表示域，并由实际梯度定义正向单位法线。这里采用C²光滑边界资格；矩形的角点另条以分面公式保存，不假设边界通量恒等式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def outwardNormalFor {n : ℕ} (A : Set (MolecularDynamics.Chapter05Review.E n)) (ν : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ z ∈ frontier A,∃ O : Set (MolecularDynamics.Chapter05Review.E n),∃ r : MolecularDynamics.Chapter05Review.E n → ℝ,
    IsOpen O ∧ z ∈ O ∧ ContDiffOn ℝ 2 r O ∧
    (∀ x ∈ O,x ∈ A ↔ r x < 0) ∧ MolecularDynamics.Chapter05Review.grad r z ≠ 0 ∧
    ν z=‖MolecularDynamics.Chapter05Review.grad r z‖⁻¹ • MolecularDynamics.Chapter05Review.grad r z
```

### MD-5.2.2-GeneralFluxBalance
```json
{
  "source_id": "MD-5.2.2-GeneralFluxBalance",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "this same rate of change may be written as the negative of the particle flux over the boundary of $A$:\n\\[\\frac{d\\vartheta}{dt}=-\\int_{\\partial A}f\\cdot n\\,\\rho(z;t)\\,d\\sigma.\\]\nUsing the divergence theorem, we may rewrite the latter quantity as a volume integral:\n\\[\\frac{d\\vartheta}{dt}=-\\int_A\\nabla\\cdot(f(z)\\rho(z;t))\\,d\\omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.generalFluxBalance",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]保留一般开放流不变相空间D，A闭包在D内，实际受限密度Measure.map条件及光滑有界域/真实法线资格；不要求ρ在D外光滑或归一化。两个原通量与散度结论都保存。矩形分面版本另列，未用单一区域计算替代此条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem generalFluxBalance : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ν f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
  (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  0 < n → IsOpen D → IsOpen A → closure A ⊆ D → Bornology.IsBounded A → outwardNormalFor A ν →
  ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → (∀ t,Φ t '' D=D) →
  ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) → (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t,HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A)
    (-(∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)))) t ∧
    (∫ z in A,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```

### MD-5.2.2-Divergence
```json
{
  "source_id": "MD-5.2.2-Divergence",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "$M_fw=-\\nabla\\cdot(wf)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.divergence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Fréchet导数的线性迹，等价坐标偏导和需要标准有限维接口；不以任意矩阵命名Jacobian。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```

### MD-5.2.2-Liouvillian
```json
{
  "source_id": "MD-5.2.2-Liouvillian",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "The operator $M_f$, defined for a scalar valued function $w$ by $M_fw=-\\nabla\\cdot(wf)$, is called the Liouvillian operator.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实乘积向量场的导数迹，不把形式符号当闭算子已构造。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.liouvillian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def liouvillian {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  -MolecularDynamics.Chapter05Review.divergence (fun x => u x • f x) z
```

### MD-5.2.2-LiouvilleEquation
```json
{
  "source_id": "MD-5.2.2-LiouvilleEquation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "Therefore, since this should hold for an arbitrary domain $A$, we must have\n\\[\\frac{\\partial\\rho}{\\partial t}=-\\nabla\\cdot(\\rho f).\\]\nThis is called the Liouville equation or continuity equation. It tells us how the distribution of phase points varies in time and space.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.liouvilleEquation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一般开放流不变D内的真实光滑密度及实际输运条件；不假设连续性方程，不要求域外ρ光滑，不构造一般PDE解存在或唯一性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem liouvilleEquation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z) t
```

### MD-5.2.2-LiouvilleProduct
```json
{
  "source_id": "MD-5.2.2-LiouvilleProduct",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "An alternative form for the continuity equation is:\n\\[\\frac{\\partial\\rho}{\\partial t}=-\\sum_i\\left(\\rho\\frac{\\partial f_i}{\\partial z_i}+f_i\\frac{\\partial\\rho}{\\partial z_i}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.liouvilleProduct",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确ρ和f在z的真实可微性；原全部坐标乘积展开由线性迹与Df/ρ链式规则表达。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem liouvilleProduct :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  MolecularDynamics.Chapter05Review.liouvillian f ρ z = -ρ z*MolecularDynamics.Chapter05Review.divergence f z-MolecularDynamics.Chapter05Review.lie f ρ z
```

