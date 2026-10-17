# BATCH29 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.2-MassGibbsStationary
```json
{
  "source_id": "MD-6.4.2-MassGibbsStationary",
  "kind": "extra_claim",
  "label": null,
  "section": "6.4.2",
  "printed_page": "247",
  "pdf_page": "268",
  "statement_latex": "We have a stationary distribution if $\\mathcal L^*\\rho=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.massGibbsStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实任意正质量与匹配β⁻¹噪声；完整原Gibbs权重的形式stationarity验证，不将它计为Markov演化测度不变性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem massGibbsStationary : ∀ {n : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ) (γ β : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → 0 < γ → 0 < β →
  ∀ x, MolecularDynamics.Chapter06Review.langevinMassForward m U γ β
    (fun z ↦ Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0
```

### MD-6.4.2-UnitMassGibbsStationaryBridge
```json
{
  "source_id": "MD-6.4.2-UnitMassGibbsStationaryBridge",
  "kind": "extra_claim",
  "label": null,
  "section": "6.4.2",
  "printed_page": "247",
  "pdf_page": "268",
  "statement_latex": "We have a stationary distribution if $\\mathcal L^*\\rho=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.unitMassGibbsStationaryBridge",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinForwardDifferentialOperator_gibbs_eq_zero"
  ],
  "extra_assumptions": [
    "[EXTRA]现成真实单位质量原机械Hamiltonian权重、σ²=2γ/β的前向形式表达；未代表任意质量或真实过程测度不变性全部已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem unitMassGibbsStationaryBridge {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Differentiable ℝ U) (β γ σ : ℝ) (hβ : 0 < β)
    (hσ : σ ^ 2 = 2 * γ / β) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ σ (textbookLangevinGibbsWeight U β) z = 0
```

### MD-6.4.2-CylinderCoordinates
```json
{
  "source_id": "MD-6.4.2-CylinderCoordinates",
  "kind": "extra_claim",
  "label": null,
  "section": "6.4.2",
  "printed_page": "247",
  "pdf_page": "268",
  "statement_latex": "Now consider an SDE system defined on the space $D=\\mathbb T^{k_1}\\times\\mathbb R^{k_2}$ for non-negative integers $k_1$ and $k_2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.cylinderCoordinates",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际圆环商坐标与Euclidean非紧坐标；局部微分表达通过周期lift解释，不偷换D为纯ℝⁿ。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def cylinderCoordinates {k₁ k₂ : ℕ} (z : Fin (k₁+k₂) → ℝ) :
    (Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ) :=
  (fun i ↦ (z ⟨i.val, by omega⟩ : AddCircle (1 : ℝ)), fun j ↦ z ⟨k₁+j.val, by omega⟩)
```

### MD-6.4.2-CylinderSDE
```json
{
  "source_id": "MD-6.4.2-CylinderSDE",
  "kind": "definition",
  "label": "(6.43)",
  "section": "6.4.2",
  "printed_page": "247",
  "pdf_page": "268",
  "statement_latex": "Now consider an SDE system defined on the space $D=\\mathbb T^{k_1}\\times\\mathbb R^{k_2}$ for non-negative integers $k_1$ and $k_2$:\n\\[dX=b_0(X)dt+\\sum_{i=1}^r b_i dW_i;\\tag{6.43}\\]\nwhere $b_0$ is $C^\\infty$ and the $W_i$ are independent standard Wiener processes. In this book, we will only consider the analysis for the case of additive noise (i.e. the $b_i$ vectors multiplying a Wiener process are constant).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.cylinderSDE",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实D及其周期lift、原C∞漂移、常矩形B和全部严格Ito积分；仅方程意义，不预置遍历/不变结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def cylinderSDE {Ω : Type*} [MeasurableSpace Ω] {k₁ k₂ r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ))
    (X : ℝ → Ω → ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)))
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ) (x0 : Fin (k₁+k₂) → ℝ) : Prop :=
  ContDiff ℝ ∞ (fun z ↦ b₀ (cylinderCoordinates z)) ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  ∃ lift : ℝ → Ω → (Fin (k₁+k₂) → ℝ),
    strictVectorSDE P W lift (fun z _ ↦ b₀ (cylinderCoordinates z)) (fun _ _ ↦ B) x0 ∧
    (∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → X t sample=cylinderCoordinates (lift t sample))
```

### MD-6.4.2-CylinderGenerator
```json
{
  "source_id": "MD-6.4.2-CylinderGenerator",
  "kind": "definition",
  "label": null,
  "section": "6.4.2",
  "printed_page": "247",
  "pdf_page": "268",
  "statement_latex": "Working in flat $L^2$ space, we have that the infinitesmal generator for (6.43) acting on a smooth test function $\\phi(X)$ is\n\\[\\mathcal L\\phi=b_0\\cdot\\nabla\\phi+\\tfrac12\\operatorname{Tr}(B^T\\phi''B);\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "D上标量检验的真实周期lift表达；非紧方向真实导数，不断言任意不光滑输入仍是经典generator域。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.cylinderGenerator",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def cylinderGenerator {k₁ k₂ r : ℕ}
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ)
    (φ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → ℝ) (z : Fin (k₁+k₂) → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorGenerator (fun y ↦ b₀ (cylinderCoordinates y)) B
    (fun y ↦ φ (cylinderCoordinates y)) z
```

### MD-6.4.2-CylinderForwardPrinted
```json
{
  "source_id": "MD-6.4.2-CylinderForwardPrinted",
  "kind": "definition",
  "label": null,
  "section": "6.4.2",
  "printed_page": "247",
  "pdf_page": "268",
  "statement_latex": "Taking the adjoint, the forward Kolmogorov or Fokker-Planck operator is $\\mathcal L^*$, acting on a density $\\rho(X)$ as\n\\[\\mathcal L^*\\rho=-\\nabla\\cdot(b_0\\rho)+\\tfrac12\\operatorname{Tr}(B^T\\phi''B).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "印刷forward密度算子仍写φ″，应ρ″；本条保留两个不同对象的字面表达，不宣称其是密度演化算子。"
    }
  ],
  "lean_decl": "MD.Ch06.cylinderForwardPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]周期lift中的完整实际负散度与错误φ扩散，正确ρ算子已有VectorForward定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "扩散项中的φ″改为ρ″。",
      "corrected_decl": "MD.Ch06.cylinderForwardPrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def cylinderForwardPrinted {n r : ℕ} (b₀ : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ φ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  -(∑ i, fderiv ℝ (fun z ↦ b₀ z i*ρ z) x (Pi.single i 1)) +
    MolecularDynamics.Chapter06Review.vectorDiffusion B φ x
```

### MD-6.4.2-StationaryDensity
```json
{
  "source_id": "MD-6.4.2-StationaryDensity",
  "kind": "definition",
  "label": null,
  "section": "6.4.2",
  "printed_page": "247",
  "pdf_page": "268",
  "statement_latex": "We have a stationary distribution if $\\mathcal L^*\\rho=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "仅实际形式stationarity；非负、归一化、generator域及真实kernel演化另给，不能由定义计测度不变性已证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.stationaryDensity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def stationaryDensity {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) : Prop :=
  ∀ x, MolecularDynamics.Chapter06Review.vectorForward a B ρ x=0
```

### MD-6.4.2-StationaryInvariant
```json
{
  "source_id": "MD-6.4.2-StationaryInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.2",
  "printed_page": "247",
  "pdf_page": "268",
  "statement_latex": "This is completely analogous to the deterministiccase in which stationary distributions were defined by $\\mathcal L^*\\rho=0$ where $\\mathcal L^*$ refers to the Liouvillian. Any stationary solution is also referred to as an invariant probability distribution, or invariant probability measure for the system. The condition $\\mathcal L^*\\rho=0$ implies the property that the distribution is unchanged in time, $\\exp(t\\mathcal L^*)\\rho=\\rho$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.stationaryInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Markov kernel semigroup、真实generator对演化检验的导数关系与弱stationarity，并明确局部可积支配保证求导换积分；完整kernel测度不变，未假设不变结论或把形式exp当实际流。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem stationaryInvariant :
  ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (L : (D → ℝ) → D → ℝ),
  MolecularDynamics.Chapter06Review.markovSemigroup K → IsProbabilityMeasure μ →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → ∀ T : ℝ, 0 ≤ T →
    ∃ bound : D → ℝ, Integrable bound μ ∧ ∀ s ∈ Icc 0 T, ∀ x,
      |L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal y) x| ≤ bound x) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) →
    (∀ t, Integrable (L (fun x ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t x)) μ) ∧
    (∀ x t, HasDerivWithinAt (fun s : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal x)
      (L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal y) x) (Ici 0) t)) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → (∫ x, L f x ∂μ)=0) →
  MolecularDynamics.Chapter06Review.invariantKernel K μ
```

