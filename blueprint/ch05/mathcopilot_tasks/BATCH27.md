# BATCH27 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.6-DynamicalCorrection
```json
{
  "source_id": "MD-5.6-DynamicalCorrection",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "209",
  "pdf_page": "230",
  "statement_latex": "The interpretation of a dynamical average (e.g. an autocorrelation function) as a stationary average means that we can apply the perturbation result to such computations as well.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.dynamicalCorrection",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]固定lag的真实光滑pullback观测量及统一紧正则能量带；H参数改变时flow本身改变所导致的额外误差未自动忽略。本条完整平均校正关系不以结论为前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem dynamicalCorrection :
  ∀ n d (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c t,
    0 < n → ContDiff ℝ ⊤ H → ContDiff ℝ ⊤ η → ContDiff ℝ ⊤ w →
    ContDiff ℝ ⊤ a → ContDiff ℝ ⊤ b → ContDiff ℝ ⊤ (Φ t) → MolecularDynamics.Chapter05Review.regularEnergy H c →
    (∃ δ > 0, ∃ K : Set (MolecularDynamics.Chapter05Review.E n), IsCompact K ∧ MolecularDynamics.Chapter05Review.energySurface H c ⊆ K ∧
      (∀ z ∈ K,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) ∧
      ∀ ε ∈ Ioo (-δ) δ,MolecularDynamics.Chapter05Review.regularEnergy (fun z => H z+ε*η z) c ∧
        MolecularDynamics.Chapter05Review.energySurface (fun z => H z+ε*η z) c ⊆ K) →
    let g := fun z => inner ℝ (a (Φ t z)) (b z)
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |MolecularDynamics.Chapter05Review.microAverage H c g-MolecularDynamics.Chapter05Review.microAverage (fun z => H z+ε*η z) c g-
        MolecularDynamics.Chapter05Review.perturbationCorrection H η g w c ε| ≤ C*ε^2
```

### MD-5.6-ForwardNormDivergence
```json
{
  "source_id": "MD-5.6-ForwardNormDivergence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $(q_0,p_0)=(0,0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.forwardNormDivergence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]独立修正为实际范数发散，不覆盖原两分量字面版；h≠0及非原点。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem forwardNormDivergence : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖) atTop atTop
```

### MD-5.6-WeakStationary
```json
{
  "source_id": "MD-5.6-WeakStationary",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "the only solution, in the weak sense, of $\\mathcal L_{\\widetilde f}^{*}\\rho=0$ is the point distribution $\\delta[q]\\delta[p]$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.weakStationaryModel",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]复用§5.3.2已经定义的真实弱Liouville稳态：所有C∞紧支测试函数的Lie导数可积且配对为零，允许Dirac等奇异概率；与离散Measure.map不变分别陈述，不从名称推出等价。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def weakStationaryModel {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  MolecularDynamics.Chapter05Review.weakStationary f μ
```

### MD-5.6-WeakAttractor
```json
{
  "source_id": "MD-5.6-WeakAttractor",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "this solution is not “asymptotically stable.”",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.weakAttractor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]“attractive”取概率弱拓扑中某邻域内所有初值概率的有界连续测试函数收敛；邻域以有限测试族和正ε明确，不把个别轨道收敛当全密度吸引。此为三个后续结论共用的技术定义；不添加已收敛或已不变的前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def weakAttractor {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∃ m : ℕ,∃ ψ : Fin m → MolecularDynamics.Chapter05Review.E n → ℝ,∃ ε > 0,
    (∀ i,Continuous (ψ i) ∧ Bornology.IsBounded (range (ψ i))) ∧
    ∀ ν : Measure (MolecularDynamics.Chapter05Review.E n),IsProbabilityMeasure ν →
      (∀ i,|(∫ z,ψ i z ∂ν)-(∫ z,ψ i z ∂μ)| < ε) →
      ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun t => ∫ z,φ (Φ t z) ∂ν) atTop (𝓝 (∫ z,φ z ∂μ))
```

### MD-5.6-EulerLogField
```json
{
  "source_id": "MD-5.6-EulerLogField",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "the only solution, in the weak sense, of $\\mathcal L_{\\widetilde f}^{*}\\rho=0$ is the point distribution $\\delta[q]\\delta[p]$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.eulerLogField",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]单位振子Euler的实际实线性logarithmic modified场；取h>0时正/负径向率分别对应前/后Euler，旋转率arctan(h)/h。真实模型的一步对应及ODE资格另条，定义本身不证明无限BEA展开收敛。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def eulerLogField (backward : Bool) (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  WithLp.toLp 2 ![a*z 0+b*z 1,a*z 1-b*z 0]
```

### MD-5.6-EulerLogFlow
```json
{
  "source_id": "MD-5.6-EulerLogFlow",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.eulerLogFlow",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]为两种实际线性modified场写出完整连续时间指数旋转流；不是把任意算法的有限截断当精确解。只有本单位线性振子的对应作为独立待证明义务。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def eulerLogFlow (backward : Bool) (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]
```

### MD-5.6-EulerLogCorrespondence
```json
{
  "source_id": "MD-5.6-EulerLogCorrespondence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "206–207",
  "pdf_page": "227–228",
  "statement_latex": "Let us assume that the perturbed equation is a realistic model for the numerical solutions. Applying Forward Euler to the harmonic oscillator, we have $q_{n+1}=q_n+hp_n$, $p_{n+1}=p_n-hq_n$. As an alternative, consider the Backward Euler method: $q_{n+1}=q_n+hp_{n+1}$, $p_{n+1}=p_n-hq_{n+1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.eulerLogCorrespondence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]只对书中实际单位线性振子给出选定logarithmic场与两Euler更新的真实对应及全部t的ODE；不把更新等式或ODE作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem eulerLogCorrespondence : ∀ h : ℝ,0 < h →
  (∀ z,eulerLogFlow false h h z=MolecularDynamics.Chapter05Review.forwardEuler h z ∧
    eulerLogFlow true h h z=MolecularDynamics.Chapter05Review.backwardEuler h z) ∧
  (∀ backward z t,HasDerivAt (fun s => eulerLogFlow backward h s z)
    (eulerLogField backward h (eulerLogFlow backward h t z)) t)
```

### MD-5.6-ForwardWeakStationary
```json
{
  "source_id": "MD-5.6-ForwardWeakStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "To put it another way, the only solution, in the weak sense, of $\\mathcal L_{\\widetilde f}^{*}\\rho=0$ is the point distribution $\\delta[q]\\delta[p]$, and this solution is not “asymptotically stable.”",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.forwardWeakStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际概率弱稳态和弱拓扑非吸引两个结论；选择上一条给出的真实modified场/流及正h。离散不变概率唯一性不替代本弱PDE与非吸引结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem forwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField false h) (MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField false h) μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  ¬weakAttractor (eulerLogFlow false h) (MolecularDynamics.Chapter05Review.diracMeasure 2)
```

