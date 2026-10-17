# BATCH42 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.5-KernelEvolution
```json
{
  "source_id": "MD-6.4.5-KernelEvolution",
  "kind": "definition",
  "label": null,
  "section": "6.4.5",
  "printed_page": "257",
  "pdf_page": "278",
  "statement_latex": "Given a collection of phase space points distributed according to the density $\\rho_0(q,p)$, its evolution under Langevin dynamics after a time $t$ will be described by\n\\[\\rho(q,p,t)=e^{t\\mathcal L_{LD}^*}\\rho_0(q,p).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.kernelEvolution",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实Markov kernel应用初始measure的compProd边缘，形式exp解释为实际演化，非无资格幂级数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def kernelEvolution {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (μ : Measure D) (t : ℝ≥0) : Measure D := K t ∘ₘ μ
```

### MD-6.4.5-KernelAverage
```json
{
  "source_id": "MD-6.4.5-KernelAverage",
  "kind": "definition",
  "label": null,
  "section": "6.4.5",
  "printed_page": "258",
  "pdf_page": "279",
  "statement_latex": "The average of a function $\\varphi$ with respect to the distribution at time $t$ is equivalent to the average of the forward propagation of $\\varphi$ with respect to the initial distribution.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.kernelAverage",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实核积分的backward检验函数传播，可积资格在Duality定理明确。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def kernelAverage {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (f : D → ℝ) (t : ℝ≥0) (x : D) : ℝ := ∫ z, f z ∂K t x
```

### MD-6.4.5-DensityEvolutionMeaning
```json
{
  "source_id": "MD-6.4.5-DensityEvolutionMeaning",
  "kind": "definition",
  "label": null,
  "section": "6.4.5",
  "printed_page": "257–258",
  "pdf_page": "278–279",
  "statement_latex": "More precisely this relation should be interpreted in the variational sense, so that for any suitable test function $\\varphi$, e.g. $\\varphi\\in C^\\infty$,\n\\[\\int_D\\varphi\\rho(q,p,t)d\\omega=\\int_D\\varphi e^{t\\mathcal L_{LD}^*}\\rho_0(q,p)d\\omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.densityEvolutionMeaning",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实初始概率density、全部时刻density及实际kernel measure等式的语义定义；未假设每个任意SDE必存在平滑density，未计存在性已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def densityEvolutionMeaning {n : ℕ} (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (ρ0 : textbookLangevinPeriodicPhase n → ℝ) (ρ : ℝ≥0 → textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  (∀ x, 0 ≤ ρ0 x) ∧ Integrable ρ0 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, ρ0 x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  ∀ t, (∀ x, 0 ≤ ρ t x) ∧ Integrable (ρ t) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
    MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ0 x))) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ t x))
```

### MD-6.4.5-KernelDuality
```json
{
  "source_id": "MD-6.4.5-KernelDuality",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.5",
  "printed_page": "258",
  "pdf_page": "279",
  "statement_latex": "Due to the properties of the inner product, we may interpret the right hand side as\n\\[\\int_D(e^{t\\mathcal L_{LD}}\\varphi)(q,p)\\rho_0(q,p)d\\omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.kernelDuality",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]全部实际可测可积检验、真实Markov kernel及初始概率measure；非仅Brownian谱模型配对。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem kernelDuality :
  ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (t : ℝ≥0) (f : D → ℝ),
  IsProbabilityMeasure μ → IsMarkovKernel (K t) → Measurable f →
  Integrable f (MolecularDynamics.Chapter06Review.kernelEvolution K μ t) →
  (∫ x, f x ∂MolecularDynamics.Chapter06Review.kernelEvolution K μ t) = ∫ x, MolecularDynamics.Chapter06Review.kernelAverage K f t x ∂μ
```

### MD-6.4.5-SmoothTestL2Printed
```json
{
  "source_id": "MD-6.4.5-SmoothTestL2Printed",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.5",
  "printed_page": "258",
  "pdf_page": "279",
  "statement_latex": "Since all the eigenvalues lie to the left of a vertical line in the left half plane, for any $\\varphi$ in $C^\\infty$ we have\n\\[\\int_D\\varphi\\rho(q,p,t)d\\omega=\\operatorname{Av}_\\beta(\\varphi)+\\alpha e^{t\\lambda_1}\\int_D\\varphi\\rho^{(1)}d\\omega.\\]\nThe latter integral is bounded since both $\\varphi$ and $\\rho^{(1)}$ are in $L^2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "环面×无界动量上C∞不自动L²；常数1已不在flat L²，指数增长函数也可能不在Gibbs L²。需适当weighted空间/增长资格。"
    }
  ],
  "lean_decl": "MD.Ch06.smoothTestL2Printed",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "明确要求检验函数属于所选L²空间；给出正确检验函数域定义，不冒称所有C∞函数可积。",
      "corrected_decl": "MD.Ch06.smoothTestL2Printed_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem smoothTestL2Printed : ∀ {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ),
  ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) →
  MemLp f 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)
```

### MD-6.4.5-ComplexInitialDensity
```json
{
  "source_id": "MD-6.4.5-ComplexInitialDensity",
  "kind": "definition",
  "label": null,
  "section": "6.4.5",
  "printed_page": "258",
  "pdf_page": "279",
  "statement_latex": "Assume that $\\lambda_1,\\rho^{(1)}$ is some eigenvalue, eigenfunction pair with $\\operatorname{Re}(\\lambda_1)<0$ and take the initial distribution to be\n\\[\\rho_0=\\rho_{eq}+\\alpha\\rho^{(1)},\\qquad\\alpha\\in\\mathbb R.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.complexInitialDensity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确真实初始概率的实性/非负/积分1，原单复模式不自动是概率；保留复Lp空间与复本征值，未缩成实负λ玩具。复共轭成对构造可另建，但原单模式需这些资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def complexInitialDensity {n : ℕ}
    (ρeq ρ1 : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) (α : ℝ) : Prop :=
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (ρeq x).im=0 ∧ 0 ≤ (ρeq x).re) ∧
  Integrable (fun x ↦ (ρeq x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
    (ρeq x+(α : ℂ)*ρ1 x).im=0 ∧ 0 ≤ (ρeq x+(α : ℂ)*ρ1 x).re) ∧
  Integrable (fun x ↦ (ρeq x+(α : ℂ)*ρ1 x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x+(α : ℂ)*ρ1 x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1
```

### MD-6.4.5-LangevinForwardSemigroupMeaning
```json
{
  "source_id": "MD-6.4.5-LangevinForwardSemigroupMeaning",
  "kind": "definition",
  "label": null,
  "section": "6.4.5",
  "printed_page": "257–258",
  "pdf_page": "278–279",
  "statement_latex": "\\[\\rho(q,p,t)=e^{t\\mathcal L_{LD}^*}\\rho_0(q,p).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinForwardSemigroupMeaning",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]对所有真实非负实初始density的actual kernel/complex Lp²传播关联定义；不凭空把任意线性S命名Langevin，原forward identification仍未证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def langevinForwardSemigroupMeaning {n : ℕ}
    (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (S : ℝ≥0 → Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →L[ℂ]
      Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) : Prop :=
  ∀ v : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n),
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (v x).im=0 ∧ 0 ≤ (v x).re) →
    Integrable (fun x ↦ (v x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →
    ∀ t, MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (v x).re)) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal ((S t v x).re))
```

### MD-6.4.5-ComplexEigenmodeDecay
```json
{
  "source_id": "MD-6.4.5-ComplexEigenmodeDecay",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.5",
  "printed_page": "258",
  "pdf_page": "279",
  "statement_latex": "\\[\\rho(q,p,t)=e^{t\\mathcal L_{LD}^*}\\rho_0\n=e^{t\\mathcal L_{LD}^*}\\rho_{eq}+\\alpha e^{t\\mathcal L_{LD}^*}\\rho^{(1)}\n=\\rho_{eq}+\\alpha e^{t\\lambda_1}\\rho^{(1)}.\\]\nSince $\\operatorname{Re}(\\lambda_1)<0$, this converges exponentially to the desired average.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.complexEigenmodeDecay",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整复λ/Reλ<0及原α∈ℝ，真实flat Lp² initial probability资格；实际C0 semigroup/0处generator图关系、stationary/eigenvector为前提，完整全时exp模式及所有L²检验CS衰减为结论，没有把全时模式演化作假设。S需识别为实际Langevin前向传播，下一条登记，不冒充已识别。",
    "[EXTRA]S与原实际周期Langevin核在全部非负可积初始密度上的关联及rhoeq与真实归一Gibbs density的AE识别均显式编码；模式演化、平均恒等、CS界及极限全部为结论，仍未计forward semigroup的存在/识别已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem complexEigenmodeDecay : ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (β γ : ℝ)
    (hβ : 0 < β) (_hγ : 0 < γ), textbookIsWienerVector B P →
  let E := Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)
  ∀ (S : ℝ≥0 → E →L[ℂ] E) (A : E →ₗ.[ℂ] E) (ρeq ρ1 : E) (α : ℝ) (ev : ℂ),
    langevinForwardSemigroupMeaning
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) S →
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
      ρeq x=(textbookLangevinCanonicalDensity U β x : ℂ)) →
    S 0=ContinuousLinearMap.id ℂ E → (∀ s t, S (s+t)=(S s).comp (S t)) →
    (∀ v, Continuous (fun t : ℝ≥0 ↦ S t v)) →
    (∀ v w, (v,w) ∈ A.graph → HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal v) w (Ici 0) 0) →
    (ρeq,0) ∈ A.graph → (ρ1,ev • ρ1) ∈ A.graph → ρ1 ≠ 0 → ev.re < 0 →
    complexInitialDensity ρeq ρ1 α →
    (∀ t : ℝ≥0, S t (ρeq+(α : ℂ) • ρ1)=ρeq+((α : ℂ)*Complex.exp ((t : ℂ)*ev)) • ρ1) ∧
    (∀ f : E, ∀ t : ℝ≥0,
      ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ=⟪f,ρeq⟫_ℂ+
        ((α : ℂ)*Complex.exp ((t : ℂ)*ev))*⟪f,ρ1⟫_ℂ) ∧
    (∀ f : E, ∀ t : ℝ≥0,
      ‖⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ-⟪f,ρeq⟫_ℂ‖ ≤
        |α| * ‖f‖*‖ρ1‖*Real.exp (ev.re*(t : ℝ))) ∧
    ∀ f : E, Tendsto (fun t : ℝ≥0 ↦ ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ)
      atTop (𝓝 ⟪f,ρeq⟫_ℂ)
```

